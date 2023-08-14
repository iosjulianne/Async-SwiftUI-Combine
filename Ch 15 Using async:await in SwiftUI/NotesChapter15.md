<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 15 Notes 
-->

# Ch 15 Using async/await in SwiftUI

## Fetching Data Asynchronously Using URLSession
New `URLSession` updated to one line:

`let (data, response) = try await URLSession.shared.data(for: urlRequest)`

```
private func search(for searchTerm: String) async -> Word {
  // build the request
  let request = buildURLRequest(for: searchTerm)
do {
    let (data, response) =
      try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else
      throw WordsAPIError.invalidServerResponse
}
    let word = try JSONDecoder().decode(Word.self, from: data)
}
return word
  catch {
    return Word.empty
}
```

`async` - adding this keyword to the method declares it asynchronous<br>
`await` - Calling an asynchronous method using `await` creates a so-called **suspension
point**. While the function is suspended, the runtime can reuse the thread it was
executing on to perform other code in your application.

A **suspension point** is like being *on hold* with a call center agent. You can do other things while on hold, but when the agent returns, you resume the conversation that was suspended when you were put on hold

## Calling Asynchronous Code
To call asynchronous code, we need to be in an asynchronous context. One way to establish an asynchronous context:

Create a new `Task`

```
Task {
  let result = search(for: "Swift")
}
```

## The Task View Modifier
Need "Task {}" or will get compiler error because it's an async call; need to put `await` OR `await` and `Task{}`


`.onAppear` runs when your view appears

`.task` is the same as 

```
.onAppear {
	Task {
		await //your code
	}
}
```


## Calling Asynchronous Code When the User Taps a Button

Use `Task` instead of async (async is deprecated)


## Using Pull-to-Refresh to Update Views Asynchronously

`.refreshable` view modifier enables pull-to-refresh

```
List {
    ...
}
.refreshable {
  	await viewModel.refresh()
}

```

## Searchable Views and async/await
`.searchable` view modifier

e.g. `.searchable(text: $viewModel.searchText)`

- takes 3 parameters: `Binding` to a `String` which contains the search term, placement of search bar, and list of suggested search terms
- only really need to give search term

Use `.onSubmit(of:)` view modifier to search only when user taps search button

```
.onSubmit(of: .search) {
    Task {
      	await viewModel.executeQuery()
    }
}
```
As the closure isn’t marked `async`, we need to create
the required asynchronous context ourselves before we can call the asynchronous `executeQuery` method on the view model

## Updating the UI from the Main Thread
`@MainActor` ensures that certain parts of your Combine code execute on the main thread, also known as the main dispatch queue

To get your code back to the main thread, there are a couple of strategies:

- You can wrap any code that updates the UI in a call to `MainActor.run { }`.
-  You can mark any functions that update the UI using the `@MainActor` property wrapper.
-   You can mark the entire class that contains code updating the UI using the `@MainActor` property wrapper.