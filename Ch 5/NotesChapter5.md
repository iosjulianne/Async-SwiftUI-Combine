<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 5 Notes 
-->

# Ch 5 Displaying Data in Lists
mark any methods (or classes) that perform UI updates using the @MainActor property wrapper 

**Getting Started with Lists in SwiftUI**

[Building SwiftUI Components—Getting Started](http://www.youtube.com/watch?v=UhDdtdeW63k)

Extract the code for list rows into a separate view, making it reusable and easier to understand

Refactoring examples from video:

1. Extract Subview - `BookRowView(book: book)`
2. Extract to Method

	```
	fileprivate func detailsLabel(_ text: String) -> Text {
		return Text(text)
			.font(subheadline)
	}

3. Extract to Computed Property
	
	```
	var titleLabel: some View {
		Text(book.title)
			.font(heading)
	}
	

**Dynamic Lists**

*Using List Bindings to Allow Modifying List Items*<br>

* Normally, data inside a view is unmodifiable. 
* To modify data, it needs to be managed as a @State property or a @ObservedObject view model. 
* To allow users to modify data in a child view (e.g., a TextField or a details screen), we need to use a binding to connect the data in the child view to the state in the parent view.

Use @Binding in the child view: 

* The parent view retains ownership of the data that you pass in to the child view while letting the child view modify the data. 
* The source of truth is the @Published property on the ObservableObject in the parent view.

*Asynchronously Fetching Data*

Fetch data is when the user navigates to a new screen

* `.task` view modifier replaces `.onAppear` 
	* request data here
	* `.task` will start an asynchronous `Task` when the view appears and will cancel this task once the view disappears (if the task is still running)
	* This is useful if your task is a long-running download that you automatically want to abort when the user leaves the screen.

UI updates must be executed on the main thread

* Mark any methods (or classes) that perform UI updates using the @MainActor property wrapper. 
	* This instructs the compiler to switch to the main actor when executing this code and thus makes sure any UI updates run on the main thread. 

*Pull-to-Refresh*

`
    .refreshable {
      await viewModel.refresh()
    } 
    `
    
As indicated by the `await` keyword, `refreshable` opens an asynchronous execution context. 

* This requires that the code you’re calling from within refreshable can execute asynchronously
* Can also execute nonasynchronously, but more often than not you’ll want to communicate with a remote API that requires being called asynchronously

Provide the value parameter,to make sure this animation is only run when the contents of the list view change

`.animation(.default, value: viewModel.books)`


*Searching*

`.searchable` view modifier to the list view, and SwiftUI will handle all the UI aspects for you automatically:
	
* displays a search field (and makes sure it is offscreen when you first display the list view, just like you’d expect from a native app). 
* triggers the search and clears the search field


How does this Combine pipeline work?

1. We use Publishers.CombineLatest to take the latest state of the two publishers, $originalBooks and $searchTerm. In a real-world application, we might receive updates to the collection of books in the background, and we’ll want these to be included in the search result as well. The CombineLatest publisher will publish a new tuple containing the latest value of original-
Books and searchTerm every time one of those publishers sends a new event. 
2. We then use the .map operator to transform the (books, searchTerm) tuple into an array of books that we eventually assign to the published $booksproperty, which is connected to the SearchableBooksListView.
3. Inside the .map closure, we use filter to return only the books that contain the search term either in their title or in the author’s name. This part of the process actually is not Combine-specific—filter is a method on Array.

**Styling**

*List Styles*
*Headers and Footers*
*List Cells*
*Separators*

**Actions**

*Swipe-to-Delete*
*Moving and Deleting Items Using EditMode*
*Swipe Actions*
*Basic Swipe Actions*
*Specifying the Edge*
*Swipe Actions and onDelete*
*Adding More Swipe Actions*
*Full Swipe*
*Styling Your Swipe Actions*

**Managing Focus in Lists**
*How to Manage Focus in SwiftUI*
*How to Manage Focus in Lists*
*Handling the Enter Key*
*What About MVVM?*
*Eliminating Empty Elements*

