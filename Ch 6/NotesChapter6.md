<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 6 Notes 
-->

# Ch 6 Building Input Forms

## Building Simple Forms
```
 Form {
      Text("Hello, world!")
 }
```
Can add:

- Text
- Image
- Label
- Toggle
- Button

## Showing Data in a Form

`Toggle` expects a binding, so it can update the underlying property whenever the user flips the switch

- Use `.constant()` to turn the binding into a constant value

## Make It Editable
`TextField` has `NumberFormatter()` to translate between number data type and text

```
TextField("Pages", value: $book.pages, formatter:
NumberFormatter())
```

## Drill-Down Navigation

- `Book` struct - serves as the model for an individual book
- We need to establish a *source of truth* that contains a collection of all the books in our app

The best way to hold a collection of elements and update any subscribers about changes to this list is to use an `ObservableObject` with a property that is marked as `@Published`:

```
class BooksViewModel: ObservableObject {
  @Published var books: [Book] = Book.samples
}
```

`App` struct is a good place to instantiate and pass around the view model.

- this makes sure our source of truth is shared among all windows of our application

Use `@StateObject` to tell SwiftUI that it needs to ensure to keep this instance of `BooksViewModel` alive across any screen redraws

```
import SwiftUI
@main
struct BookShelfApp: App {
  @StateObject var booksViewModel = BooksViewModel()
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        BooksListView(booksViewModel: booksViewModel)
          .navigationTitle("Books")
          } 
   	 }
	} 
}
```

- Use `List` bindings to ensure the individual items of the list are editable
- Use `NavigationLink` to specify the destination
view when the user taps on one of the books in the list

When the user taps on the Edit button on the BookDetailsView, we open a modal sheet to display BookEditView.

```
Button(action: { showEditBookView.toggle() }) {
        Label("Edit", systemImage: "pencil")
      }
    }
    .sheet(isPresented: $showEditBookView) {
      BookEditView(book: $book)
    }
```


## Input Validation
Checking user's input of a book ISBN 
### Using .onChange(of:)

### Using a View Model to Handle Form Validation

 Structs do have memberwise initializers, but classes don’t. The main reason is that classes support inheritance, and it would be pretty difficult to implement memberwise initializers
in a way that doesn’t break if you add new properties to one of the parent classes.

### Synchronizing a Local Source of Truth with the Global Source of Truth by Using @Binding and @ObservableObject

### Using Combine to Perform Form Validation
