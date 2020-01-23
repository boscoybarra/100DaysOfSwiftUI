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
    
