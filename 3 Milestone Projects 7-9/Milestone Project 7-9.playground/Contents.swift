import UIKit

//Why @State only works with structs.
//How to use @ObservedObject to work with classes.
//How @Published lets us announce property changes to any SwiftUI views that are watching.
//Presenting and dismissing views using the sheet() modifier and presentationMode.
//Using onDelete(perform:) to enable swipe to delete.
//Adding EditButton to navigation bar items, to let users edit list data more easily.
//Reading and writing data with UserDefaults.
//Archiving and unarchiving data with Codable, including working with data stored in a hierarchy.
//Using the Identifiable protocol to make sure all items can be identified uniquely in our user interface.
//How to use GeometryReader to make content fit the screen.
//Using ScrollView to lay out custom views in a scrollable area.
//Pushing new views onto the navigation stack using NavigationLink.
//Using Swift’s generics system to write methods that work with different kinds of data.
//How to use Swift’s first(where:) method to find the first element in an array that matches a predicate.
//Using layoutPriority() to adjust how much space is allocated to a view.
//Creating custom paths and shapes.
//Creating shapes that can be inset and have their border stroked, using InsettableShape.
//Using CGAffineTransform to create rotations and translations.
//Making creative borders and fills using ImagePaint.
//Enabling Metal for drawing complex views using drawingGroup().
//Modifying blend modes and saturation.
//Animating shapes with animatableData and AnimatablePair.




//
//Classes vs structs: what’s the difference and why does it matter?
//


//The fundamental difference between a class and a struct is that one is a value type and the other is a reference type. These are standard programming terms for how we work with data: is the data just a simple value such as “Hello” or 5, or is it a merely a signpost saying “my data is stored in RAM at this location.”

//Once you understand that different, structs and classes become two very different things, but when you’re learning those differences can feel not very different at all. Think of it like this: when we make a variable that holds a struct that data is literally stored inside the variable, but when we use a class that data is put in memory somewhere and the variable holds a long number that identifies the location of that memory.



//
//Using UserDefaults wisely
//


//UserDefaults lets us store small amounts of data easily – it’s automatically attached to our app, which means it’s there ready to load as soon as our app launches. While it’s very useful (and you’ll be relying on its heavily!) it does have two drawbacks:
//
//You should only store small amounts of data there – anything over about 512KB is dubious.
//You can only store certain types of data easily; everything else must use Codable first to get some binary data.

//The list of types that are supported by UserDefaults is short and precise: strings, numbers, dates, URLs, and binary data, plus arrays and dictionaries of those types. Excluding URLs (which are really just fancy strings), all those are the same types that can be stored in a plist file – short for a property list.


//This isn’t a coincidence: UserDefaults actually writes out its data using a property list just like our Info.plist file. In fact, keeping this link in mind can really help you make the best of UserDefaults – it would be strange if our Info.plist file contained 100,000 entries of data, and it’s just as strange to put 100,000 items in UserDefaults.



//When to use generics

func makeString() -> Comparable {
    "Hello"
}


//
//The key anout generics

//We used generics to create a decoding method that is capable of taking any JSON file from an app bundle and loading into a Codable type of our choosing. But – and this is a big but! – we first wrote the method to be non-generic: if you recall, it originally decoded an array of astronauts before being upgraded to load any kind of Codable type.

//
//So, the key to using generics well is not to use them at first, and when you do need them to add restrictions so that you get the most functionality you can.
