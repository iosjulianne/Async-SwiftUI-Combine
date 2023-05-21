<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 13 Notes 
-->


# Ch 13 Combine Schedulers and SwiftUI

By default, SwiftUI code runs on main thread

## What Is a Scheduler

`Scheduler` 

- a Combine mechanism 
- an abstraction that allows us to specify when and where our code is running so we don't have to work directly with threads
- is a protocol that defines when and how to execute a closure


`SchedulerTimeType` - associated type used to implement time-keeping in schedulers
`SchedulerTimeIntervalConvertible` - `SchedulerTimeType` - needs to conform to this protocol, which is a means to express relative time

## Types of Schedulers

- `ImmediateScheduler` - default scheduler; executes code immediately on the same thread that triggered the pipeline 
- `RunLoop` - performs work on a specific run loop.
- `DispatchQueue` - allows us to execute code on specific dispatch queues. Most common: main dispatch queue, background dispatch queues; can also make custom queues

**RunLoop vs DispatchQueue**<br>

- Both are common and very similar
- When using DispatchQueue scheduler, the pipeline will continue to deliver events when user interacts with UI
- When using RunLoop scheduler, the pipeline will *not* continue to deliver events when user interacts with UI

## Default Behavior

By default, code runs on the same thread as the event that triggered the pipeline

- Validating user input can usually run on same thread
- When accessing the network (or asynch data source), run parts of the pipeline on background thread
- Use `DispatchQueue` to switch threads explicitly (between `.main` and `.global()` or a custom queue)

## Switching Schedulers
Key operators for scheduling:

* `receive(on:)` - allows us to tell Combine which scheduler to use when receiving events in our subscribers, such as `sink` or `assign`
* `subscribe(on:)` - use it to specify which scheduler Combine should use when subscribing to an upstream publisher
* `debounce`
* `throttle`
* `delay`
* `Future` - runs closure immediately, so need to wrap it inside a `Deferred` publisher to ensure closure will only be executed once we connect a subscriber

### Controlling Upstream Publishers Using subscribe(on:)
By using the subscribe(on:) operator, you can control on which dispatch queue the upstream publisher runs on

- Useful if you want to make sure the publisher runs on a background thread
- Can use subscribe(on:) instead of wrapping code in `DispatchQueue.global().async{ }`

### Controlling Downstream Subscribers Using receive(on:)
By using the receive(on:) operator, you can influence which scheduler Combine
will use for all downstream operators and subscribers

- Useful for making sure the subscribers of a Combine pipeline run on the main thread

### Other Operators That Influence Scheduling

- `debounce` publishes elements only after a specified time interval elapses be- tween events.
- `throttle` publishes either the most recent or the first element published by the upstream publisher in the specified time interval.
- `delay` delays delivery of all output to the downstream receiver by a specified amount of time on a particular scheduler.

time interval and a scheduler

## Performing Asynchronous Work

Access async APIs on background thread by subscribing to the respective publisher (or operator) on a background scheduler. 
When the background process has finished, and the publisher emits an event, you will eventually want to switch to the main thread to update the UI.

Here is the general pattern to use/*Combine best practice*:

```
publisher
  .subscribe(on: DispatchQueue.global())
  .receive(on: DispatchQueue.main)
  .sink { }
```
**DispatchQueue.global(qos:)**<br>

- `background`: Background tasks have the lowest priority of all tasks. Assign this class to tasks or dispatch queues that you use to perform work while your app is running in the background.
- `utility`: Utility tasks have a lower priority than default, user-initiated, and user-interactive tasks, but a higher priority than background tasks. Assign this quality-of-service class to tasks that do not prevent the user from continuing to use your app. For example, you might assign this class to long-running tasks whose progress the user does not follow actively.
- `default`: Default tasks have a lower priority than user-initiated and user-inter- active tasks, but a higher priority than utility and background tasks. Assign this class to tasks or queues that your app initiates or uses to perform active
work on the user’s behalf.
- `userInitiated`: User-initiated tasks are second only to user-interactive tasks in
their priority on the system. Assign this class to tasks that provide immediate results for something the user is doing, or that would prevent the user from using your app. For example, you might use this quality-of-service class to load the content of an email that you want to display to the user.
- `userInteractive`: User-interactive tasks have the highest priority on the sys- tem. Use this class for tasks or queues that interact with the user or actively update your app’s user interface. For example, use this for class for animations or for tracking events interactively.

## Integrating with Other APIs

### URLSession
`URLSession` executes on a background thread

Add a `receive(on:)` operator before the `assign` operator, to make sure we access the UI from the main thread

### Firebase
Since Firestore takes care of dispatching all operations on the most appropri-
ate dispatch queue (a serial background queue for fetching data and the main dis-
patch queue for returning results), there is usually no need to switch the dispatch
queue.
