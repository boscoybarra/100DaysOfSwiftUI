import SwiftUI

//How to read numbers from users with Stepper, including using its shorter form when your label is a simple text view.

//Letting the user enter dates using DatePicker, including using the displayedComponents parameter to control dates or times.

//Working with dates in Swift, using Date, DateComponents, and DateFormatter

//How to bring in machine learning to leverage the full power of modern iOS devices.

//Building scrolling tables of data using List, in particular how it can create rows directly from arrays of data.

//Running code when a view is shown, using onAppear().

//Reading files from our app bundle by looking up their path using the Bundle class, including loading strings from there.

//Crashing your code with fatalError(), and why that might actually be a good thing.

//How to check whether a string is spelled correctly, using UITextChecker.

//Creating animations implicitly using the animation() modifier.

//Customizing animations with delays and repeats, and choosing between ease-in-ease-out vs spring animations.

//Attaching the animation() modifier to bindings, so we can animate changes directly from UI controls.

//Using withAnimation() to create explicit animations.

//Attaching multiple animation() modifiers to a single view so that we can control the animation stack.

//Using DragGesture() to let the user move views around, then snapping them back to their original location.

//Using SwiftUI’s built-in transitions, and creating your own.


//Ranges with ForEach and List

ForEach(0..<5) {
    Text("Row \($0)")
}
//
//
//ForEach(0...5) {
//   Text("Row \($0)")
//}

//That counts from 0 through 5, meaning that it will create six views. Or at least it would create six views if it actually worked – that code doesn’t compile.

let name = "Paul🤓"
name.count
