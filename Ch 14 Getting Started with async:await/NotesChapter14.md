<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 14 Notes 
-->


# Ch 14 Getting Started with async/await

The most common reasons why functions execute *asynchronously* 

1. they require a response from a slow resource (e.g., a server that needs to be accessed via the network, or even a file on the local file system)
2. they perform expensive work (i.e., a long-running computation)

Blocking calls on a server will result in more threads to handle other requests, resulting in a *thread explosion*, and the server running out of resources quickly.

## Synchronous Programming with Functions

*synchronously* - tasks performed one after another

Easy to write and understand since it follows a linear flow

## Asynchronous Programming with Closures
Common way to implement asynchronous code: Grand Central Dispatch (GCD) and closures

*Closures* are self-contained blocks of functionality that can be passed around and used in your code

When dealing with asynchronous code, closures are most commonly used as *trailing closures*

Problems with using closures for handling asynchronous behavior in our app:

1. **It is easy to end up in a pyramid of doom.**
2. **Error handling will make the code even harder to read.**
3. **It is not always clear which thread a callback is on.**
4. **There is no way to enforce a completion handler be called.**

## Asynchronous Programming with async/await
Swift 5.5 introduces new concurrency model

### Defining and Calling Asynchronous Functions
*suspension points* – the places where a function can be suspended

-  you indicate a suspension point by using the `await` keyword when calling an asynchronous function or method
`let result = await someAsyncFunction()`

To define an asynchronous function or method, you use the `async` keyword

```
func someAsyncFunction() async -> String {
  let result = // ... async code here
  return result
}
```

`async/await` differences compared to completion handler–based version of the code:

1. We no longer have to provide a parameter for the trailing closure. Instead, we use the `async` keyword

2. We can now specify the return value of this function. Remember, when using the completion handler, the return value had to be part of the completion handler signature. 

3. No need to use `DispatchQueue.global().async { }`—SwiftUI’s new concurrency model uses a thread pool and will automatically manage threads for us

### Calling Asynchronous Functions in Parallel
`async let` - execute several asynchronous functions simultaneously
`async let x = someAsyncFunction()`

- As long as there are enough resources available, the system will run these at the same time, in parallel 
- None of these calls will create a suspension point, meaning that any code that comes after will be executed immediately