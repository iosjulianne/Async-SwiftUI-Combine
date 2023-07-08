
<!--
http://github.com/iosjulianne
Asynchronous Programming with SwiftUI and Combine
by Peter Friese
Chapter 3 Notes 
-->

# Ch 3 SwiftUI Building Blocks

**Views** - the most basic components for building UIs in SwiftUI

* Use SwiftUI's built-in views to create a lightweight description of your user interface 
* By doing so, you compose your own views, which you can then use in your app
* Can also extract views into a Swift package for reuse
* *Swift Package Index* - a search engine for packages that support the Swift Package Manager
* SwiftUI views are structs that need to conform to the View protocol.
	* conformers need to implement a computed property
named body that returns a single View
	* By using container views, we can meet the View protocol’s requirement of returning a single View from the body computed property.

*opaque type* - by returning the result of a view’s body as `some View`, the caller will only see a view and doesn’t get any insight into how this view is structured

###User Interface Views
SwiftUI's User interface elements:

**Text Output**

* Text - Displays one or more lines of read-only text 
* Label - Displays an image and read-only text
  **Text Input**

* TextField - Displays editable text
* SecureField - Lets the user securely enter text
* TextEditor - A control that can display and edit long-form text

**Images**

* Image - Displays an image
* AsyncImage - Asynchronously downloads and displays an image
**Controls**

* Button - A control that initiates an action
* EditButton - A button that toggles the edit mode environment value
* Link - A control for navigating to a URL 
* Menu - A control for presenting a menu of actions 

**Value Inputs**

* Slider - A control for selecting a value from a bounded linear range of values
* Stepper - A control that performs increment and decrement actions
* Toggle - A control that toggles between on and off states

**Pickers**

* Picker - A control for selecting from a set of mutually exclusive values
* DatePicker - A control for selecting an absolute date
* ColorPicker - A control used to select a color from the system color picker UI

**Indicators**

* Gauge - A view that shows a value within a range
* ProgressView - A view that shows the progress toward completion of a task
  
**Shapes**

* Shape - A 2D shape that you can use when drawing a view
* Rectangle - A rectangular shape aligned inside the frame of the view containing it
* Circle - A circle centered on the frame of the view containing it
* Capsule - A capsule shape aligned inside the frame of the view containing it
* Path - The outline of a 2D shape


**Container Views**

* *Layout containers* - HStack, VStack, or ZStack
* *Collection Containers* - List, Form, Table, Group, or ScrollView provide built-in features like scrolling, swiping, filtering, and more.
* *Presentation Containers* - NavigationView, NavigationStack, NavigationSplitView, TabView, Toolbar, etc. define the structure of your app’s UI.


*Layout Behavior*
	
1. The parent view offers some size to its child view.
2. The child view then decides how much space it requires, taking into consideration its own size (the intrinsic size) and the space that the parent view offered (which the child view is free to ignore completely). It then returns this size to the parent view.
	* Hugging - The view chooses the best size to fit its content, without consulting the size offered by its parent view. 
		* e.g. Text will consume just space required, even if the container offers more space.
	* Expanding - The view tries to use up as much space as offered by its parent view. 
		* e.g. Color will take up the entire space offered by the parent view.
3. The parent view uses the size returned by the child to lay out the child view somewhere within the bound of the space it offered in step 1. It will respect the size that the child requested for itself.

*Views Are Just Descriptions of the UI*<br>
You should not perform any expensive processing or computations inside the initializers of your views.


**View Modifiers**

* Style your views
* Respond to events (like the user tapping on a button)
* Configure secondary views (like swipe actions, context menus, or toolbars)


The order in which view modifiers are added to a view matters!<br>

Most view modifiers also impact the children of the view they are applied to<br>

