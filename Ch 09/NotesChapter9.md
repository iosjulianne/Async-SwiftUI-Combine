<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 9 Notes 
-->


# Ch 9 Networking with Combine

*callback*<br>
*source of truth* - usually your in-memory data model

Combine helps combine your local source of truth with data from a remote service

## Fetching Data Using URLSession
Common problems: 

- unclear what the path is
- completion handlers can be confusing
- error handling all over the place
- several exit points
- forget to call `resume()` 


## Using Combine to Fetch Data

The resulting code has 

- fewer exit points
- follows a straight line
- is easier to read and maintain
- less prone to subtle bugs

Use `dataTaskPublisher` to perform the request <br>

- one-shot publisher 
- emits an event once the requested data has arrived 
- Combine publishers don’t perform any work if there is no subscriber

### Destructuring Tuples Using Key Paths
*Destructuring* - extracting the individual elements from the result tuple

```
return URLSession.shared.dataTaskPublisher(for: url)
	.map(\.data)
```

### Mapping Data
Dedicated operator to make mapping data easier: `decode(type:decoder:)`

```
return URLSession.shared.dataTaskPublisher(for: url)
  .map(\.data)
  .decode(type: UserNameAvailableMessage.self, 
  		decoder: JSONDecoder())
```

### Fetching Data Using Combine, Simplified

## Connecting to the UI

Since `@Published` properties are Combine publishers, we can subscribe to
them to receive updates whenever their value changes.

Make pipeline reusable to preserve memory and avoid wasting CPU cycles:

 - wrap it inside a *lazy computed property*. Lazy computed properties are computed only once, and only if they are accessed.


## Handling Multithreading
Do not access the UI from a background thread. Instead use `receive(on:)` operator

## Optimizing Network Access
*idempotent* - an operation or function that can be applied multiple times without changing the result beyond the initial application

### Finding the Root Cause
Use `print()` for debugging

### Using the share Operator to Share a Publisher
`share()` - share the results of a publisher with multiple subscribers

### Is it a bug or a feature?
bug: https://github.com/peterfriese/AppleFeedback/tree/main/FB9826727

### Using debounce to Further Optimize the UX
`debounce` - it will drop all events until there is a pause and then it will pass on the most recent event to the downstream publisher
 
 - for example, will only send username after user finishes typing

### Using removeDuplicates to Avoid Sending the Same Request Twice
`removeDuplicates` will remove any duplicate events from the stream of events if they follow each other subsequently

Together, `removeDuplidates` and `debounce` help reduce requests

## Bringing It All Together
`Publishers.CombineLatest()` to combine publishers