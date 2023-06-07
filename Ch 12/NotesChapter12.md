<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 12 Notes 
-->


# Ch 12 Wrapping Existing APIs in Combine

## A Case Study
Firebase


## Using Combine to Access Firestore

### Using View Models and Published Properties
### Using Combine to Wrap APIs
- The Combine framework provides a declarative Swift API for processing values over time
- Apple discourages developers from implementing their own publishers using Combine’s low-level primitives (such as Publisher, Subscription, and Subscriber)

## Creating Your Own Publishers
Create custom publishers using Combine's higher-level building blocks such as `Passthrough` and `Future`

### Using PassthroughSubject to Wrap Snapshot Listeners
 `Subject`s are a special kind of publisher that allow outside callers to inject events into a Combine pipeline. The `Subject` protocol defines a `send(_:)` method that can be used to send specific values to the pipeline.


### Using Future to Implement One-Time Fetching from Firestore

`Future`- a Publisher that “eventually produces a single value and then finishes or fails"