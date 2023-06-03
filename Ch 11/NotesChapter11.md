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

## Implementing Custom Operators

## Conditionally Retrying

## Implementing a Retry Operator for Exponential Backoff

