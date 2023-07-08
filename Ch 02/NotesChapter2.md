<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 2 Notes 
-->
# Ch 2 Getting Started with SwiftUI

* SwiftUI puts a strong focus on building reusable UI components<br>
* Sample books - allows us to display some demo data without having to fetch data from an API<br>
* Rename `ContentView` to reflect the functionality of the screen more closely<br>
* Refactor your code as soon as you recognize it’s starting to get out of hand<br>
* Show light and dark mode: Variants --> Color Scheme Variants


` some View `<br>
`some` indicates an *opaque return type*


**Composability**
SwiftUI views can be made up of other views.<br>
Container components: *HStack*, *VStack*, *ZStack*<br>
*Spacer* - component that dynamically takes up space between other components

To make `Book` struct `Identifiable`:

- Conform to Identifiable protocol `struct Book: Identifiable`.
- Add var id = UUID().uuidString to the Book’s attributes.


**Making the Code Reusable**

*pyramid of doom* - deeply nested code; avoid it by composing your UI of many small, use case–specific components

SwiftUI mechanisms to decompose view structures into smaller blocks, making our code easier to read and maintain:

* Extract Subview
* Extract to Method 
* Extract to Property

Considerations after Extract Subview:

1. Marking the extracted subview as private (If you’re not going to use this view in any other context.
2. Move it to a separate file (If you are going to use the extract subview elsewhere)


**Views and View Modifiers**

*Views* are the core building blocks of SwiftUI—each view defines a piece of the UI.

There are two main ways to configure views:

1. The main properties of a view can be configured using constructor arguments (e.g., the text displayed on a Text view, or the alignment of a HStack). 
2. Secondary properties of a view are configured using View Modifiers.

*View Modifiers* are functions that you call on SwiftUI views (e.g., Text("hello").font(.headline)). Most of these allow you to specify the look of a view
view modifiers also allow you to register closures that are called upon certain events (such as a button tap).



