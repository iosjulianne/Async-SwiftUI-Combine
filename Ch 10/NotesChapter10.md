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
### Calling the API and Handling Errors
### Handling Device/Network Offline Errors
### Handling Validation Errors
### Handling Response Parsing Errors
### Handling Internal Server Errors