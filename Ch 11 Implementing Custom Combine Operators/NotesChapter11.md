<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 11 Notes 
-->


# Ch 11 Implementing Custom Combine Operators

## What Is a Combine Operator?

1. **Publishers** - deliver values over tiime
2. **Subscribers** - act on these values as they receive them
3. **Operators** - sit in the middle between publishers and subscribers and can be used to manipulate the stream of values
	- `map` (and `tryMap`) to transform elements
	- `debounce` to publish elements only after a pause between two events
	- `removeDuplicates` to remove duplicate events
	- `flatMap` to transform elements into a new publisher

## Implementing Custom Operators

Create our own custom operators by extending `Publisher` with a function that returns a publisher (or subscriber) that operates on the events it receives from the publisher we use it on

`dump()` - prints the contents of a variable to the console, showing the structure of the variable as a nested tree — similar to the debug inspector in Xcode

`handleEvents` - combine operator that allows you to observe and react to different events that occur during the lifecycle of a publisher

## Implementing a Retry Operator with a Delay
Use the `tryCatch` operator, so need to use its publisher type `Publishers.TryCatch` as the return type


## Conditionally Retrying
 Add a parameter for a trailing closure that the caller can use to control whether the operator should retry or not to make code reusable

## Implementing a Retry Operator for Exponential Backoff
*Exponential backoff* is commonly utilized as part of rate limiting mechanisms in computer systems such as web services, to help enforce fair distribution of access to resources and prevent network congestion

The idea behind exponential backoff is to progressively increase the delay between retry attempts when a network request fails
