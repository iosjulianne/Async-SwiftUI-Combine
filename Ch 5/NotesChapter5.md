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


*Searching*




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

