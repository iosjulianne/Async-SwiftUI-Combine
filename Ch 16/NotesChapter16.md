<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 16 Notes 
-->


# Ch 16 Bringing It All Together: SwiftUI, async/await, and Combine

## Fetching Data Using Combine
Use `URLSession` to fetch data from a URL, call `dataTaskPublisher`, then use some of Combine’s operators tohandle the response and transform it into a data model our application can work with

```
private func searchBooks(matching searchTerm: String) -> AnyPublisher<[Book], Never> {
  	let escapedSearchTerm = searchTerm
  		.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed ?? ""
	let url = URL(string: "https://openlibrary.org/search.json?q=\(escapedSearchTerm)")!
		return URLSession.shared.dataTaskPublisher(for: url)
    		.map(\.data)
    		.decode(type: OpenLibrarySearchResult.self,
            decoder: JSONDecoder())
    		.map(\.books)
    		.compactMap { openLibraryBooks in
    			openLibraryBooks?.map { Book(from: $0) }
}
    		.replaceError(with: [Book]())
    		.eraseToAnyPublisher()
}

```

*"Getting into a functional reactive mindset probably is one of the biggest hurdles when learning Combine."*


## Fetching Data Using async/await
Implementing the same method using `async/await`, wrapping inside a `try` `catch` block.

```
private func searchBooks(matching searchTerm: String) async -> [Book] 
{
	let escapedSearchTerm = searchTerm
		.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
	let url = URL(string: "https://openlibrary.org/search.json?q=\
(escapedSearchTerm)")!
	do {
   		let (data, _) = try await URLSession.shared.data(from: url)
   		let searchResult = try OpenLibrarySearchResult.init(data: data)
   		guard let libraryBooks = searchResult.books else {
			return []
  		}
   		return libraryBooks.compactMap { Book(from: $0) }
	}
	catch {
		return []
	}
}
```

## Is This the End of Combine?
Comparing two code snippets:

- `async/await` version can be read top to bottom
- combine version - have to know what a publisher is and some code is nested; can be confusing


## Connecting the UI...
```
struct BookSearchCombineView: View {
  @StateObject var viewModel = ViewModel()
  var body: some View {
    List(viewModel.result) { book in
      BookSearchRowView(book: book)
    }
    .searchable(text: $viewModel.searchTerm)
  }
}

```

## ...to a Combine Pipeline

## ...to an async/await Method

## Calling Asynchronous Code from Combine

