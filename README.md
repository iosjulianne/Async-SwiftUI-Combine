# Async-SwiftUI-Combine
Code for Peter Friese's book, Asynchronous Programming with SwiftUI and Combine 

<a href="https://www.amazon.com/Asynchronous-Programming-SwiftUI-Combine-Functional/dp/1484285719/"><strong>Buy the book »</strong></a>
<br />
      

<!-- ABOUT THE PROJECT -->
## About

This repo contains code for the book, my notes and solutions to the exercises.

<a href="https://github.com/peterfriese/Asynchronous-Programming-with-SwiftUI-and-Combine/"><strong>Book's code samples »</strong></a>
<br />


<!-- GENERAL NOTES -->
### 📚 Vocabulary
**DSL** - Domain Specific Language<br>
**Opaque type** - "some" keyword turns type into opaque type. This means that the compiler still has access to the underlying concrete type, but clients of the module don’t — they just see the protocol of the return value<br>
**pyramid of doom** - deeply nested code that’s difficult to navigate<br>
**source of truth** - the data that determines the state of the UI. There can only be one source of truth for each UI element.<br>
**callback** - a function that is passed as an argument and executes when a specific condition or event occurs<br>
**idempotent** - if you perform the operation or function once or multiple times, the outcome remains the same<br>
**toast** - an overlay that shows for a brief moment and then disappears<br>
**payload** - the data sent from a server in response to a network request<br>
**exponential backoff** - a strategy used in networking and communication protocols to handle retries and manage network congestion; progressively increase the delay between retry attempts when a network request fails<br>
**projected value** - a combine term that refers to a property or value that is projected from a publisher or operator. It allows you to access additional information or perform further operations on the publisher or operator<br>
**synchronously** - tasks performed one after another<br>
**asynchronously** - not happening or done at the same time or speed <br> **thread explosion** - a situation where a program or system creates an excessive number of threads, causing resource exhaustion and degradation in performance<br>
**closures** - self-contained blocks of functionality that can be passed around and used in your code<br> 
**suspension points** – the places where a function can be suspended


### 🔥 Hot Keys
* Run *(CMD + R)*
* Debug Console *(CMD + Shift + C)*
* Resume Preview *(CMD + Option + P)*
* Preview Canvas *(CMD + Option + Enter)*
* Xcode Library *(CMD+Shift+L)* 
* Embed in stack or list *(CMD + click stack --> embed)*

### 🌟 Study Circle Videos
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 1 (Planning)](https://www.youtube.com/watch?v=mtA6eie1Dsw)
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 2 (Chapters 1-3)](https://www.youtube.com/watch?v=ELxsFvNdRkY)
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 3 (Chapter 4) - SwiftUI: State Management](https://www.youtube.com/watch?v=B76Q_l1Do4Q)
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 4 (Chapters 5-6) - SwiftUI: State Management](https://www.youtube.com/watch?v=5ZoWCbfRyHM)
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 5 (Chapters 7-8) - Combine: Introduction](https://www.youtube.com/watch?v=n9SFqHxDozI)
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 6 (Chapter 9) - Networking with Combine](https://www.youtube.com/watch?v=XiL07wvmYb4)
* Session 7 - TBA
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 8 (Chapter 10) - Error Handling](https://www.youtube.com/watch?v=lpBE6iuYqPk)
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 9 (Chapter 11) - Implementing Custom Operators in Combine](https://www.youtube.com/watch?v=WfnP7ju0F0A)
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 10 (Chapter 12) - Wrapping Existing APIs in Combine](https://www.youtube.com/watch?v=1JS5D36lGb0)
* [iOS Study Circle: Asynchronous Programming with SwiftUI - Session 11 (Chapter 13) - Combine Schedulers and SwiftUI](https://www.youtube.com/watch?v=qZky1xlPQ4M)

### 🔬 Extra Resources (shared in Slack)

* [Using map, flatMap and compactMap in Combine – Donny Wals](https://www.donnywals.com/using-map-flatmap-and-compactmap-in-combine/)
* [When to Use Combine's TryMap Instead of Map – Cocoacasts](https://cocoacasts.com/combine-essentials-when-to-use-combine-trymap-instead-of-map)


* [Getting Started with Combine Framework in Swift - Introduction to Functional Reactive Programming – Karin Prater](https://www.youtube.com/watch?v=tbzR-eHr6oo&list=PLWHegwAgjOkoIMgZ7QF_SHUtEB_rWXtH0)


### 🐣 To Do

* Watch session 6
* Watch session 8
* Watch session 9
