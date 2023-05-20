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
- an abstraction that allows us to specify when and where our code is run so we don't have to work directly with threads
- is a protocol that defines when and how to execute a closure

`SchedulerTimeType`

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


However, as soon as you need to access the network (or any other asyn- chronous data source), things become more complicated, and you will want to run parts of the pipeline on a background thread before coming back to the main thread to update the UI.

Assigning and updating can crash your code because it's on a separate thread

## Switching Schedulers

### Controlling Upstream Publishers Using subscribe(on:)
### Controlling Downstream Subscribers Using receive(on:)

By using the subscribe(on:) operator, you can control on which dispatch queue the upstream publisher runs on.

### Other Operators That Influence Scheduling

- debounce publishes elements only after a specified time interval elapses be- tween events.
- throttle publishes either the most recent or the first element published by the upstream publisher in the specified time interval.
- delay delays delivery of all output to the downstream receiver by a specified amount of time on a particular scheduler.

time interval and a scheduler

## Performing Asynchronous Work

you should offload any such code to a background thread by subscribing to the respective publisher (or operator) on a background scheduler. When the background process has finished, and the publisher emits an event, you will eventually want to switch to the main thread to update the UI.

Here is the general pattern to use/*Combine best practice*:

```
publisher
  .subscribe(on: DispatchQueue.global())
  .receive(on: DispatchQueue.main)
  .sink { }
```

## Integrating with Other APIs

### URLSession
### Firebase


Combine uses schedulers as a declarative alternative that helps developers ab-
stract away from having to manually wrap your code in calls to DispatchQueue.-
main.async { } etc. Instead, we can use Combine operators like subscribe(on:)
and receive(on:) to declare which scheduling strategy Combine should use.