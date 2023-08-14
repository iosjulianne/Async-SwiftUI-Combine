<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 7 Notes 
-->


# Ch 7 Getting Started with Combine

**What is Functional Reactive Programming?**

Everything that happens is an event<br>
Events usually happen asynchronously (not at the same time)

Ways to deal with asynchronous behavior:

1. 	delegates and callbacks
2. 	reactive programming<br>
		- Events are sent by an event source<br>
		- Interested parties can register to receive certain events<br> 
		- More often than not, streams of events need to be transformed to make them more useful for the respective subscriber

Combine v RxSwift - Combine is more deeply integrated into Apple’s platforms since it is made by Apple

Combine is a unified, declarative API for processing values over time. 

Combine defines three main concepts to implement the idea of reactive programming:
 
1. Publishers - deliver values over time. Each publisher defines which kinds of 
values and errors (if any) it publishes. 
	- *Just* - most basic publisher

2. Subscribers - act on these values as they receive them 
	
	Two main subscribers of Combine framework:
	1. Sink - the most generic one; you can use it to receive values from a Combine publisher and then execute whatever code you like inside its closure. 
	2. Assign - lets you assign any received values to a property or to another Publisher. 

3. Operators - sit in the middle between publishers and subscribers and can be used to manipulate the stream of values.
Often, you will need to modify the values before they can be used by the subscriber. Operators can be combined to form powerful pipelines. 

*CompactMap* calls a closure with each received 
element and publishes any returned optional that has a value <br>
	1. All nil values will be removed from the result.<br>
	2. The result will no longer be optional. 


**Composing Operators**<br>
Operators are so special because they can subscribe to a publisher and act as a publisher at the same time. 

**Combining Publishers**<br>
