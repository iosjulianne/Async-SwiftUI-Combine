<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 15 Notes 
-->

Notes from Vid:

suspension point - 
call center agent "hold the line"

Need "Task {}" or will get compiler error because it's an asynch call; need to put `await` OR `await` and `Task{}`


# Ch 15 Using async/await in SwiftUI

**Fetching Data Asynchronously Using URLSession**

**Calling Asynchronous Code**

**The Task View Modifier**

`.onAppear` runs when your view appears

`.task` is the same as 
```
.onAppear {
	Task {
		await // code
	}
}
```


**Calling Asynchronous Code When the User Taps a
Button**

Use task instead of async (async is deprecated)


**Using Pull-to-Refresh to Update Views Asynchronously**

**Searchable Views and async/await**



**Updating the UI from the Main Thread**

@MainActor
