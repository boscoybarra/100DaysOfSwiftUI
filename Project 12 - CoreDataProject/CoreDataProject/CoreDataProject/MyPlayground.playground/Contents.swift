//import UIKit
//
//var str = "Hello, playground"
//
//
////Why does \.self work for ForEach?
//
//
//List {
//    ForEach([2, 4, 6, 8, 10], id: \.self) {
//        Text("\($0) is even")
//    }
//}
//
//
// }
//}
//
////All this matters because when Xcode generates a class for our managed objects, it makes that class conform to Hashable, which is a protocol that means Swift can generate hash values for it, which in turn means we can use \.self for the identifier. This is also why String and Int work with \.self: they also conform to Hashable.
//
////Hashable is a bit like Codable: if we want to make a custom type conform to Hashable, then as long as everything it contains also conforms to Hashable then we don’t need to do any work. To demonstrate this, we could create a custom struct that conforms to Hashable rather than Identifiable, and use \.self to identify it:
//
//struct Student: Hashable {
//    let name: String
//}
//
//struct ContentView: View {
//    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
//
//    var body: some View {
//        List(students, id: \.self) { student in
//            Text(student.name)
//        }
//   
//
//
////Warning: Although calculating the same hash for an object twice in a row should return the same value, calculating it between two runs of your app – i.e., calculating the hash, quitting the app, relaunching, then calculating the hash again – can return different values.
//
//
//
////
////Creating NSManagedObject subclasses
////
//
//
////Before you leave the data model editor, I’d like you to go to the View menu and choose Inspectors > Show Data Model Inspector, which brings up a pane on the right of Xcode containing more information about whatever you have selected right now.
//
////When you select Movie you’ll see a variety of data model options for that entity, but there’s one in particular I’d like you to look at: “Codegen”. This controls how Xcode generates the entity as a managed object class when we build our project, and by default it will be Class Definition. I’d like to change that to Manual/None, which gives us full control over how the class is made.
//
////Now that Xcode is no longer generating a Movie class for us to use in code, we can’t use it in code unless we actually make the class with some real Swift code. To do that, go to the Editor menu and choose Create NSManagedObject Subclass, make sure “CoreDataProject” is selected then press Next, then make sure Movie is selected and press Next again. You’ll be asked where Xcode should save its code, so please make sure you choose “CoreDataProject” with a yellow folder icon on its left, and select the CoreDataProject folder too. When you’re ready, press Create to finish the process.
//
//
////
//// Important
////
//
////However, it’s also common to bulk your saves together so that you save everything at once, which has a lower performance impact. In fact, Apple specifically states that we should always check for uncommitted changes before calling save(), to avoid making Core Data do work that isn’t required.
//
//
////
//// Conditional saving of NSManagedObjectContext
////
//
////import SwiftUI
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//    
//    var body: some View {
//        Button("Save") {
//            
////  Fortunately, we can check for changes in two ways. First, every managed object is given a hasChanges property, that is true when the object has unsaved changes. And, the entire context also contains a hasChanges property that checks whether any object owned by the context has changes.
//
////So, rather than call save() directly you should always wrap it in a check first, like this:
//        
//            if self.moc.hasChanges {
//                try? self.moc.save()
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
////Ensuring Core Data objects are unique using constraints
//
//        struct ContentView: View {
//            @Environment(\.managedObjectContext) var moc
//
//            @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
//
//            var body: some View {
//                VStack {
//                    List(wizards, id: \.self) { wizard in
//                        Text(wizard.name ?? "Unknown")
//                    }
//
//                    Button("Add") {
//                        let wizard = Wizard(context: self.moc)
//                        wizard.name = "Harry Potter"
//                    }
//
//                    Button("Save") {
//                        do {
//                            try self.moc.save()
//                        } catch {
//                            print(error.localizedDescription)
//                        }
//                    }
//                }
//            }
//        }
//        
//        
////  Inside SceneDelegate:
////import CoreData
////  That asks Core Data to merge duplicate objects based on their properties – it tries to intelligently overwrite the version in its database using properties from the new version. If you run the code again you’ll see something quite brilliant: you can press Add as many times as you want, but when you press Save it will all collapse down into a single row because Core Data strips out the duplicates.
//context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//
//
//// Filtering @FetchRequest using NSPredicate
//
//import CoreData
//import SwiftUI
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: nil) var ships: FetchedResults<Ship>
//
//    var body: some View {
//        VStack {
//            List(ships, id: \.self) { ship in
//                Text(ship.name ?? "Unknown name")
//            }
//
//            Button("Add Examples") {
//                let ship1 = Ship(context: self.moc)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: self.moc)
//                ship2.name = "Defiant"
//                ship2.universe = "Star Trek"
//
//                let ship3 = Ship(context: self.moc)
//                ship3.name = "Millennium Falcon"
//                ship3.universe = "Star Wars"
//
//                let ship4 = Ship(context: self.moc)
//                ship4.name = "Executor"
//                ship4.universe = "Star Wars"
//
//                try? self.moc.save()
//            }
//        }
//    }
//}
//
////For example, we could ask for ships that are from Star Wars, like this:
//@FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships: FetchedResults<Ship>
//
//
////That gets complicated if your data includes quote marks, so it’s more common to use special syntax instead: `%@‘ means “insert some data here”, and allows us to provide that data as a parameter to the predicate rather than inline.
//
////So, we could instead write this
//
//NSPredicate(format: "universe == %@", "Star Wars"))
//
//
////As well as ==, we can also use comparisons such as < and > to filter our objects. For example this will return Defiant, Enterprise, and Executor:
//
//NSPredicate(format: "name < %@", "F")) var ships: FetchedResults<Ship>
//
////%@ is doing a lot of work behind the scenes, particularly when it comes to converting native Swift types to their Core Data equivalents. For example, we could use an IN predicate to check whether the universe is one of three options from an array, like this:
//
//NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
//
////We can also use predicates to examine part of a string, using operators such as BEGINSWITH and CONTAINS. For example, this will return all ships that start with a capital E:
//
//NSPredicate(format: "name BEGINSWITH %@", "E"))
//
////That predicate is case-sensitive; if you want to ignore case you need to modify it to this:
//
//NSPredicate(format: "name BEGINSWITH[c] %@", "e"))
//
////CONTAINS[c] works similarly, except rather than starting with your substring it can be anywhere inside the attribute.
//
////Finally, you can flip predicates around using NOT, to get the inverse of their regular behavior. For example, this finds all ships that don’t start with an E:
//
//NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
//
////If you need more complicated predicates, join them using AND to build up as much precision as you need, or add an import for Core Data and take a look at NSCompoundPredicate – it lets you build one predicate out of several smaller ones.
//
//
//
//
////Dynamically filtering @FetchRequest with SwiftUI
//
//



//One-to-many relationships with Core Data, SwiftUI, and @FetchRequest


