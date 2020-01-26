import UIKit

struct PushButton: View {
    let title: String
    
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ContentView: View {
    
    @State private var rememberMe = false
    
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//This is the power of @Binding: as far as the button is concerned it’s just toggling a Boolean – it has no idea that something else is monitoring that Boolean and acting upon changes.


//SwiftUI gives each of our views access to a shared pool of information known as the environment, and we already used it when dismissing sheets. If you recall, it meant creating a property like this:

@Environment(\.presentationMode) var presentationMode
Then when we were ready we could dismiss the sheet like this:

Text("Hello World")
    .onTapGesture {
        self.presentationMode.wrappedValue.dismiss()
    }

//This approach allows SwiftUI to make sure the correct state is updated when the view is dismissed – if we attached an @State property to present the sheet, for example, it would be set back to false when the sheet was dismissed.

// Enviroment size classes

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            return HStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle)
        } else {
            return HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle)
        }
    }
}


//Using size classes with AnyView type erasure

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Now, the logical conclusion here is to ask why we don’t use AnyView all the time if it lets us avoid the restrictions of some View. The answer is simple: performance.

//How to combine Core Data and SwiftUI

struct ContentView: View {
    
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    
        var body: some View {
            VStack {
                List {
                    ForEach(students, id: \.id) { student in
                        Text(student.name ?? "Unknown")
                    }
                }
                
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!

                    let student = Student(context: self.moc)
                    student.id = UUID()
                    student.name = "\(chosenFirstName) \(chosenLastName)"
                    
//  Finally we need to ask our managed object context to save itself. This is a throwing function call, because in theory it might fail. In practice, nothing about what we’ve done has any chance of failing, so we can call this using try? – we don’t care about catching errors.
                    
                    try? self.moc.save()
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
// KEY

//However, this time there’s a small piece of bonus work and it stems from the way SwiftUI’s environment works. You see, when we place an object into the environment for a view, it becomes accessible to that view and any views that can call it an ancestor. So, if we have View A that contains inside it View B, anything in the environment for View A will also be in the environment for View B. Taking this a step further, if View A happens to be a NavigationView, any views that are pushed onto the navigation stack have that NavigationView as their ancestor so they share the same environment.
//
//Now think about sheets – those are full-screen pop up windows on iOS. Yes, one screen might have caused them to appear, but does that mean the presented view can call the original its ancestor? SwiftUI has an answer, and it’s “no”, which means that when we present a new view as a sheet we need to explicitly pass in a managed object context for it to use. As the new AddBookView will be shown as a sheet from ContentView, we need to add a managed object context property to ContentView so it can be passed in.

// KEY 2

// You’ve already seen how we use the @Environment property wrapper to read values from the environment, but here we need to write values in the environment. This is done using a modifier of the same name, environment(), which takes two parameters: a key to write to, and the value you want to send in. For the key we can just send in the one we’ve been using all along, \.managedObjectContext, and for the value we can pass in our own moc property – we’re effectively 



// Key Review:

//We can use @Environment only once per view.
//It's a regular property wrapper, so you can use it as many times as you need.

//Type erasure lets us hide the underlying type of an object.
//SwiftUI gives us AnyView for this specific purpose.

//There are three size classes: large, regular, and compact.
//There are only two size classes: regular and compact.

//The .destructive alert button style should be used whenever the user might destroy some data.
//iOS marks destructive options in red, to make the dangerous behavior clear to users.

// If we have a managed object call book, we should call book.delete() to remove it from its managed object context.
//We should call the delete() method on a managed object context instead.

//onDelete(perform:) cannot be attached directly to a List view.
//We must attach onDelete(perform:) to a ForEach view instead.

//Integer 16 is designed to hold 16 different numbers.
//Integer 16 holds one 16-bit number.

//We must always provide a sort field for Core Data fetch requests.
//You can specify no sorting if you want; just use an empty array.

// AnyView conforms to View.
//This means we can use it anywhere we would use buttons, sliders, and more.

//We can't use onDelete(perform:) with views backed by Core Data objects.
//onDelete(perform:) doesn't care what data it works with, so it works fine with Core Data.

//We can create a testing managed object context for the purpose of SwiftUI previews.
//All we need to do is provide a concurrency type, such as main queue concurrency.

//Core Data can store up to 1000 entities of the same type.
//Core Data has effectively no limit on the number of objects we store.

//Views presented as sheets automatically share the same environment as the view that presented them.
//Views presented as sheets have their own environment, so if you want to share values you need to pass them in.

//When using the Core Data template, Xcode provides a managed object context for us.
//It also provides a persistent container, which means we're free to go ahead and start creating objects.

//Managed objects must be created inside a managed object context.
//This allows Core Data to save and delete them correctly.

//Managed object contexts automatically save themselves.
//We need to save our contexts manually by calling their save() method.
