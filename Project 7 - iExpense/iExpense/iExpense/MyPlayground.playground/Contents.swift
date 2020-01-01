import UIKit

var str = "Hello, playground"


//As you’ve seen, rather than just using @State to declare local state, we now take three steps:
//
//Make a class that conforms to the ObservableObject protocol.

//Mark some properties with @Published so that any views using the class get updated when they change.

//Create an instance of our class using the @ObservedObject property wrapper.

//The end result is that we can have our state stored in an external object, and, even better, we can now use that object in multiple views and have them all point to the same values.



//Showing and hiding views


//Example for showing for example color mode

//struct SecondView: View {

//@Environment(\.presentationMode) var presentationMode
//    var name: String
//
//    var body: some View {
//        Button("Dismiss") {
//    self.presentationMode.wrappedValue.dismiss()
//}
//    }
//}


struct SecondView: View {
    var name: String

    var body: some View {
        Text("Hello, \(name)!")
    }
}


struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@twostraws")
        }
    }
}


//Deleting items using onDelete()

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)

                }

                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}


//UserDefaults

struct ContentView: View {
//    @State private var tapCount = 0
//    In order so see the changes when we come back to the app we  ust assign this to our @State property
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")


    var body: some View {
        Button("Tap count: \(tapCount)") {
            self.tapCount += 1
//          we make sure this is saved on UserDefaults using a standar method prebuild by Swift
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

//Archiving Swift objects with Codable

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")

    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
//That data constant is a new data type called, perhaps confusingly, Data. It’s designed to store any kind of data you can think of, such as strings, images, zip files, and more. Here, though, all we care about is that it’s one of the types of data we can write straight into UserDefaults.
            
//When we’re coming back the other way – when we have JSON data and we want to convert it to Swift Codable types – we should use JSONDecoder rather than JSONEncoder(), but the process is much the same.
//
//That brings us to the end of our project overview, so go ahead and reset your project to its initial state ready to build on.
            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }

    }
}



struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)

                }

                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}



//@Published publishes change announcements automatically.
//@ObservedObject watches for those announcements and refreshes any views using the object.
//sheet() watches a condition we specify and shows or hides a view automatically.
//Codable can convert Swift objects into JSON and back with almost no code from us.
//UserDefaults can read and write data so that we can save settings and more instantly.
