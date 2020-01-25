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
