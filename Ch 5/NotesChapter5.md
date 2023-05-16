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

*List Styles*: .listStyle view modifier

1. automatic
2. grouped
3. inset
4. insetGrouped
5. plain
6. sidebar

*List Cells*

- .listRowSeparator
- .foregroundColor
- .badge
- .listRowSeparatorTint
- .listRowBackground

*Separators*

- .listSectionSeparator()
- .listSectionSeparatorTint()

**Actions**

*Swipe-to-Delete*<br>
`.onDelete` modifier has built-in swipe-to-delete function which needs to be called on `ForEach` loop inside a `List`

```
List {
      ForEach(items) { item in
        Label(item.title, systemImage: item.iconName)
      }
      .onDelete { indexSet in
        items.remove(atOffsets: indexSet)
	} 
}
```

*Moving and Deleting Items Using EditMode*<br>
`.onMove` modifier lets users rearrange items by dragging them across the list

```
.onMove { indexSet, index in
	items.move(fromOffsets: indexSet, toOffset: index)
 }
```

To turn on edit mode for a `List`:

```
.toolbar {
  EditButton()
}
```

*Swipe Actions*<br>
Set up buttons to implement actions inside `.swipeActions` view modifier

```
.swipeActions(edge: .leading) {
	Button (action: { viewModel.markItemRead(item) }) {
 		if let isRead = item.isRead, isRead == true {
          Label("Read", systemImage: "envelope.badge.fill")
       }
       else {
          Label("Unread", systemImage: "envelope.open.fill")
		} 
	}
	 .tint(.blue)
}
```
- Different from `onDelete` modifier (which is applied to `ForEach` loop inside `List`)
- More flexibility to apply different set of actions depending on row
- `edge` parameter to specify leading or trailing swipe actions

SwiftUI will stop synthesizing the delete functionality once you use the swipeActions modifier


*Full Swipe*<br>
By default, the first action for any given swipe direction can be invoked by using a full swipe

- Set `allowsFullSwipe` parameter to false to deactivate

*Styling Your Swipe Actions*<br>
`.destructive` will automatically tint the button red

**Managing Focus in Lists**<br>
*How to Manage Focus in SwiftUI*<br>
@FocusState -  a property wrapper that can be used to track and modify focus within a scene

example: if user hits save button on a simple input form and one field wasn't filled out, you can focus on it

*How to Manage Focus in Lists*<br>
Use an enum to hold the `id` of element you want to focus

```
enum Focusable: Hashable {
  case none
  case row(id: String)
}
```
Define variable `focusedReminder: Focusable?` as `@FocusState`

```
struct Reminder: Identifiable {
  var id: String = UUID().uuidString
  var title: String
}
struct FocusableListView: View {
  @State var reminders: [Reminder] = Reminder.samples
  @FocusState var focusedReminder: Focusable?
  var body: some View {
    List {
      ForEach($reminders) { $reminder in
        TextField("", text: $reminder.title)
          .focused($focusedReminder, equals: .row(id: reminder.id))
} }
    .toolbar {
      ToolbarItemGroup(placement: .bottomBar) {
        Button(action: { createNewReminder() }) {
          Text("New Reminder")
} }
} }
// ... }
```
*Handling the Enter Key*<br>

- Use `.onSubmit` view modifier to run code when the user submits a value to a view
- Triggered by enter key
- Elements will be added to end of list, but can make it so it is inserted directly after focused element

*What About MVVM?*<br>
 
 - `@FocusState` conforms to DynamicProperty, which can only be
used inside views

To synchronize the focus state between the view model and the view, we can

1. Add the `@FocusState` back to the view
2. Mark `focusedReminder` as a `@Published` property on the view model 
3. And sync them using `.onChange(of:)`


*Eliminating Empty Elements*

Attach a Combine pipeline to it and react to changes of the property. This will allow us to detect when the previously focused element is an empty element and consequently remove it.
