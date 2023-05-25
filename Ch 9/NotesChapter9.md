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

- Unclear what the path is, completion handlers can be confusing, error handling all over the place, several exit points, forget to call `resume()` 


## Using Combine to Fetch Data

- The resulting code has fewer exit points, follows a straight line, is easier to read and maintain, less prone to subtle bugs

Use `dataTaskPublisher` to perform the request <br>
	- one-shot publisher <br>
	- emits an event once the requested data has arrived <br>
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

## Handling Multithreading

## Optimizing Network Access

### Finding the Root Cause
### Using the share Operator to Share a Publisher
### Is it a bug or a feature?
### Using debounce to Further Optimize the UX
### Using removeDuplicates to Avoid Sending the Same Request Twice

## Bringing It All Together