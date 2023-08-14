<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 12 Notes 
-->


# Ch 12 Wrapping Existing APIs in Combine

## A Case Study
### Firebase
Most of Firebase’s APIs are asynchronous

There are multiple ways to asynchronously call Firebase services: 

1. completion handlers
2. Combine
3. async/await

[Calling asynchronous Firebase APIs from Swift - Callbacks, Combine, and async/await](https://peterfriese.dev/posts/firebase-async-calls-swift/)

[3 easy tips for calling async APIs | Firebase & SwiftUI](https://www.youtube.com/watch?v=j5htIyxmmzA)

**Cloud Firestore** - a horizontally scaling document-based NoSQL database in the cloud

- Data stored in Firestore is organized in documents
- A *document* is like a Swift struct: it can have any number of fields of different data types
- Documents are organized in collections, and documents can contain subcollections, allowing you to build nested data structures.


## Using Combine to Access Firestore
### Using View Models and Published Properties
Easy/common way to feed data into a Combine pipeline - create a published property in a view model

### Using Combine to Wrap APIs
2 different kinds of calls:

1. **fetching** - fetch a single document/collection/query; receive result of a call
2. **listening** - listen to updates on a single document/collection/query; receive a stream of updates (a new snapshot every time an update is made)

- The Combine framework provides a declarative Swift API for processing values over time
- Apple discourages developers from implementing their own publishers using Combine’s low-level primitives (such as Publisher, Subscription, and Subscriber)

## Creating Your Own Publishers
Create custom publishers using Combine's higher-level building blocks such as `Passthrough` and `Future`

Create publishers by using one of several types provided by the Combine framework:

- Use a concrete subclass of `Subject`, such as `PassthroughSubject`, to publish values on demand by calling its `send(_:)` method.
- Use a `CurrentValueSubject` to publish whenever you update the subject’s underlying value.
- Add the `@Published`annotation to a property of one of your own types. In doing so, the property gains a publisher that emits an event whenever the property’s value changes.

### Using PassthroughSubject to Wrap Snapshot Listeners
 `Subject`s are a special kind of publisher that allow outside callers to inject events into a Combine pipeline. The `Subject` protocol defines a `send(_:)` method that can be used to send specific values to the pipeline.

Combine has 2 built-in `Subject`s

1. `CurrentValueSubject`
2. `PassthroughSubject`

### Using Future to Implement One-Time Fetching from Firestore

`Future`- a Publisher that “eventually produces a single value and then finishes or fails"

**Futures will fire immediately**
A normal publisher will only fire if there is a subscriber. To make this transparent to the caller, we explicitly return a `Future` instead of type erasing to `AnyPublisher`.