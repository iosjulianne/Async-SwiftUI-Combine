<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 4 Notes 
-->

# Ch 4 State Management
The designers of SwiftUI decided to choose a different approach: a view in SwiftUI is either static, or it displays information that is driven by a model element. It is impossible to manipulate a SwiftUI view directly. The data that determines the state of the UI is called Source of Truth and there can only be one source of truth for each UI element. 


Source of Truth
property wrappers By making UI updates unidirectional, SwiftUI relieves you from the burden of having to make sure to always update the view and the model at the same time. 

the body of a view is a computed property, making it impossible for developers to accidentally modify a view directly 

SwiftUI provides two complementary tools that ensure you can freely manage and update your data model 

Binding Value Types
@State variable - declare and setting value; simple property types
@Binding - doesn’t own, is passed on value but can also change it
Best for managing local UI state

projected value 

Binding Objects - more complex 
The only way @StateObject, @ObservedObject, and @EnvironmentObject differ from each other is how they manage data. 

Consumer - the view that subscribes to the up- dates an ObservableObject sends; considers all property wrappers to be the same; @Published

Combine Publisher
- Swift class needs to conform to ObservableObject protocol 
- Mark some of the class’s properties as @Published

Use @StateObject, – when you need to listen to changes or updates in an ObservableObject 
– and you create the instance you want to listen to in the view itself That is, when the view you want to use the object in is the owner of the data. 

Use @ObservedObject, – when you need to listen to changes and updates in an ObservedObject 
– and the object you want to observe in a view is not created by the view, but outside of the view (e.g., in a parent view or the app struct) 

Use @EnvironmentObject, 
– when you need to listen to changes and updates in an ObservedObject – and you’d have to pass an ObservedObject through several views that don’t 
need this object before it reaches the view where you need access to the object 