import UIKit

var str = "Hello, playground"

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("New secondary")) {
                Text("Hello, World!")
            }
            .navigationBarTitle("Primary")

            Text("Secondary")
        }
    }
}

//Using alert() and sheet() with optionals

//  you can use an optional Identifiable object as your condition, and the alert or sheet will be shown when that object has a value.

struct User: Identifiable {
    var id = "Taylor Swift"
}


struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingAlert = false

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                self.selectedUser = User()
                self.isShowingAlert = true
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text(selectedUser!.id))
            }
    }
}

// Alternatinve option with force unwraping!

//That’s another property, another value to set in the onTapGesture(), and a force unwrap in the alert() modifier – if you can avoid those things you should.
struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingAlert = false

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                self.selectedUser = User()
                self.isShowingAlert = true
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text(selectedUser!.id))
            }
    }
}


// This flips between vertical and horizontal layout every time the group is tapped.

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @State private var layoutVertically = false

    var body: some View {
        Group {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
        .onTapGesture {
            self.layoutVertically.toggle()
        }
    }
}


struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
    }
}


// Adapt to the screen size

//you can write code to show horizontal layout when there’s lots of horizontal space, but switch to a vertical layout when space is reduced.

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
    }
}

//Tip: In situations like this, where you have only one view inside a stack and it doesn’t take any parameters, you can pass the view’s initializer directly to the VStack to make your code shorter:


struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }        }
    }
}


struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }        }
    }
}



