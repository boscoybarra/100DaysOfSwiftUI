import UIKit

var str = "Hello, playground"


List {
    Section(header: Text("Section 1")) {
        Text("Static row 1")
        Text("Static row 2")
    }

    Section(header: Text("Section 2")) {
        ForEach(0..<5) {
            Text("Dynamic row \($0)")
        }
    }

    Section(header: Text("Section 3")) {
        Text("Static row 3")
        Text("Static row 4")
    }
}


var body: some View {
    List {
        Section(header: Text("Section 1")) {
            Text("Static row 1")
            Text("Static row 2")
        }

        Section(header: Text("Section 2")) {
            ForEach(0..<5) {
                Text("Dynamic row \($0)")
            }
        }

        Section(header: Text("Section 3")) {
            Text("Static row 3")
            Text("Static row 4")
        }
    }
    .listStyle(GroupedListStyle())
}


List(0..<5) {
    Text("Dynamic row \($0)")
}


//In this project we’re going to use List slightly differently, because we’ll be making it loop over an array of strings. We’ve used ForEach with ranges a lot, either hard-coded (0..<5) or relying on variable data (0 ..< students.count), and that works great because SwiftUI can identify each row uniquely based on its position in the range.


struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
//static

    var body: some View {
        List(people, id: \.self) {
            Text($0)
        }
    }
}


//dynamic

List {
    ForEach(people, id: \.self) {
        Text($0)
    }
}
