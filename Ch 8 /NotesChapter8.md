<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 8 Notes 
-->


# Ch 8 Driving UI State with Combine

User inputs: keyboard, multitouch, physical gestures, voice commands<br>
Data input from remote servers and local APIs

**The View Model**<br>

* It is not possible to manipulate SwiftUI views directly or ready their state by accessing their properties<br>
* SwiftUI manages UI state by *source of truth* 
* Property wrappers connect the source of truth to the views of an application
*  @State handles local state in a view, but is not a publisher, so we cannot use it to drive any Combine pipelines
*  Marking a property as @Published turns it into a Combine publisher. 
	*  	allow us to bind the property to a UI element
	*  	allows us to attach a Combine pipeline to it
* Conforming the view model to ObservableObject makes it observable: published property changes --> the view model will emit the changed value --> SwiftUI will update all affected views

Make Combine pipelines reusable by encapsulating them in computed properties. This can help with duplicate code and scalability.

Use lazy properties to only create the pipeline once, when the view model is initialized.

`Publishers.CombineLatest` operator allows us to use the latest events sent by two upstream publishers.
