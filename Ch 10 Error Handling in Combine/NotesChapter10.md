<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 10 Notes 
-->


# Ch 10 Error Handling in Combine

## Error Handling Strategies

### Ignoring the Error
- Example error circumstances: user device temporarily offline or server is down 
- Provide feedback to users that their data isn't synched yet


### Retrying (with Exponential Backoff)
- Spread out time between retries to not overwhelm server

### Showing an Error Message
- Errors requiring user action: show model dialog
- Less severe errors: show a toast (an overlay that shows for a brief moment and then disappears)

### Replacing the Entire View with an Error View
e.g. Chrome dinosaur game when device offline

### Showing an Inline Error Message
- Use when user-provided data isn't valid
- Show error next to the respective input field


## Typical Error Conditions and How to Handle Them
- Device/network offline
- Semantic validation errors
- Response parsing errors/invalid URL
- Internal server errors

### Implementing a Fallible Network API
Return type `Never` means there is never going to be an error which can be guaranteed because errors were replaced with a return value of `false`

### Calling the API and Handling Errors
Typical approach to handling errors when using `flatMap` is to combine it with a `catch` operator

### Handling Device/Network Offline Errors
If offline, run local form validation logic, and when user finishes filling out form, show error message


### Handling Validation Errors
- Most validation errors should be handled locally on the client
- Ideally, the server should return a HTTP status code in the 4xx range

### Handling Response Parsing Errors
Sometimes the data sent by the server isn't what the client expects

`decode` operator - use to decode the response payload and throw an error in case the payload couldn’t be mapped

* it is important to make sure we’re only sending at most one network request per keystroke (`share()` operator)

### Handling Internal Server Errors
`tryCatch` operator - handles errors from an
upstream publisher by either replacing it with another publisher or throwing a new error

1. catch all errors
2. filter out the `serverError`
3. propagate all other errors along the pipeline

When we catch a `serverError`, we want to wait for a short amount of time and then restart the pipeline.

1.The `Just` publisher expects some value it can publish. Since it really doesn’t matter which value we use, we can send anything we want, even an empty tuple
2. We retry sending the request 10 times, meaning it will be sent up to 11 times in total (the original call plus the 10 retries)