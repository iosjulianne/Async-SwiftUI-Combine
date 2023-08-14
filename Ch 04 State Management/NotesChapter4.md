<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 4 Notes 
-->

# Ch 4 State Management

“in SwiftUI, the view is a function of the application’s state.”

Imperative UI flaw: developers update model and view independently often resulting in inconsistent states and partial updates

*Source of Truth* - The data that determines the state of the UI

* There can only be one source of truth for each UI element.
* This results in deterministic states and consistent user interfaces.

**Managing State in SwiftUI**

The body of a view is a computed property, making it impossible for developers to accidentally modify a view directly 

SwiftUI views are structs (value types), so when copying no other part of the app is changing data

Property wrappers Updates are unidirectional

**Binding Value Types**<br>
Value types: struct, enum<br>
@State variable - declare and setting value; simple property types

* `@State var name = "Julianne"` creates a binding for the variable
* `$name` accesses the *projected value*
	
@Binding - use if your view needs access to data defined elsewhere (e.g. parent view); doesn’t own data, but can read, write and observe it

* Bindings are especially useful when assembling a view from several smaller, specialized views. 
* They are an important tool to help create reusable views.

@State and @Binding

- Best for managing local UI state
- Avoid using for complex objects that you want to persist on disk or send across the network
- If needed, make @State `private` to make sure they cannot accidentally be modified from the outside


**Binding Objects**<br>
Binding Objects - more complex<br> 
The only way @StateObject, @ObservedObject, and @EnvironmentObject differ from each other is how they manage data. 

Consumer - the view that subscribes to the updates an ObservableObject sends; considers all property wrappers to be the same; @Published


**ObservableObject**

Combine Publisher
- Swift class needs to conform to ObservableObject protocol 
- Mark some of the class’s properties as @Published


**@StateObject**<br>
@StateObject is only created once, so data is not lost

Use @StateObject,
	
* when you need to listen to changes or updates in an ObservableObject 
* and when the view you want to use the object in is the owner of the data. 


**@ObservedObject**<br>
Using @ObservedObject to create a model object
is an antipattern that you should avoid. So if you see code like this: `@ObservedObject var foo = Bar()`, you should refactor your code and use @StateObject instead.

Use @ObservedObject,

* when you need to listen to changes and updates in an ObservedObject 
* and the object you want to observe in a view is not created by the view, but outside of the view (e.g., in a parent view or the app struct) 


**@EnvironmentObject**<br>
@EnvironmentObject fetches an ObservableObject from the environment and makes it available to the view<br>

Drawback: the compiler has no way to check if you injected an ObservableObject into the environment
before trying to fetch it using @EnvironmentObject. When trying to retrieve an object from the environment that doesn’t exist, your app will crash with a runtime error.


Use @EnvironmentObject, 

* when you need to listen to changes and updates in an ObservedObject
* and you’d have to pass an ObservedObject through several views that don’t 
need this object before it reaches the view where you need access to the object 