<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 2 Notes 
-->
# Ch 2 Getting Started with SwiftUI

**What We’re Going to Build**

**Composing a View for Displaying a Book**

**Build the View with Static Data**

**Using the Preview to Make Sure Our View Works As Intended**

**Displaying a List of Books**

**Setting Up Data Binding**

**Adjusting the Preview Canvas**

**Making the Code Reusable**

**Views and View Modifiers**

*Views* are the core building blocks of SwiftUI—each view defines a piece of the UI.
*View Modifiers* are functions that you call on SwiftUI views (e.g., Text("hello").font(.headline)). Most of these allow you to specify the look of a view
view modifiers also allow you to register closures that are called upon certain events (such as a button tap).

Sample books - allows us to display some demo data without having to fetch data from an API


Container components: HStack, VStack, ZStack
Spacer

Extract Subviews - afterwards, one of two options
1. Marking the extracted subview as private. This is useful if you’re not going to use this view in any other context.
2. If you are going to use the extract subview elsewhere, move it to a separate file. To do so, create a new SwiftUI View file using Xcode’s New File dialog, and then choose BookRowView as the file name. This makes sure that the new file contains a preview provider named BookRowView_Previews. It also contains a view name BookRowView, which you can just replace with the BookRowView implementation we extracted in the preceding steps



