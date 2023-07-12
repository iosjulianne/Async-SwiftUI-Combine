<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 16 Notes 
-->


# Ch 16 Bringing It All Together: SwiftUI, async/await, and Combine

## Fetching Data Using Combine
Use `URLSession` to fetch data from a URL, call `dataTaskPublisher`, then use some of Combine’s operators to handle the response and transform the data

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
Typical way to implement search screen

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
`searchTerm` in view model is a `@Published` property which makes it a Combine publisher, which makes it a good place to set up a pipeline. Set up in view model's initializer

```
init() {
	$searchTerm
   		.debounce(for: 0.8, scheduler: DispatchQueue.main) // (1)
    	.map { searchTerm -> AnyPublisher<[Book], Never> in // (2)
      		self.isSearching = true
    	}
       return self.searchBooks(matching: searchTerm)
    		.switchToLatest() // (3)
    		.receive(on: DispatchQueue.main) // (4)
    		.sink(receiveValue: { books in // (5)
      	self.result = books
      	self.isSearching = false
	})
   	.store(in: &cancellables) // (6)
}
```



## ...to an async/await Method
Same code with async/await takes a different approach. Instead of subscribing to the $searchTerm publisher, we create an async
method named executeQuery and create a Task that calls searchBooks

```
fileprivate class ViewModel: ObservableObject {
	@Published var searchTerm: String = ""
	@Published private(set) var result: [Book] = []
	@Published private(set) var isSearching = false
	private var searchTask: Task<Void, Never>? // (1)
	@MainActor // (7)
	func executeQuery() async {
   		searchTask?.cancel() // (2)
   		let currentSearchTerm = searchTerm.trimmingCharacters(in: .whitespaces)
    	if currentSearchTerm.isEmpty {
			result = []
    	}
      	isSearching = false
		else {
    		searchTask = Task { // (3)
     			isSearching = true // (4)
     			result = await searchBooks(matching: searchTerm) // (5)
       		if !Task.isCancelled {
       			isSearching = false // (6)
      			}
			}
		}
	}
	private func searchBooks(matching searchTerm: String) async -> [Book] {
	// ...
	}
}
```

## Calling Asynchronous Code from Combine

