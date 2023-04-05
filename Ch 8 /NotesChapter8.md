<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 8 Notes 
-->


# Ch 8 Driving UI State with Combine

User inputs: keyboard, multitouch, physical gestures, voice commands
Data input from remote servers and local APIs

**The View Model**<br>

* It is not possible to manipulate Swif- tUI views directly or ready their state by accessing their properties<br>
* SwiftUI manages UI state by *source of truth* 
* Property wrappers connect the source of truth to the views of an application
*  @State handles local state in a view, but is not a publisher, so we cannot use it to drive any Combine pipelines


**Validating the Username**


**Displaying Validation Messages**


**Encapsulating Combine Pipelines in Computed 
Properties**


**Putting it all Together**

