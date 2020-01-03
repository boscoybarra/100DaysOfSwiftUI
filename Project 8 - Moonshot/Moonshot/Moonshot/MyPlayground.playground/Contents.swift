import UIKit


Image("Example")
.resizable()
.frame(width: 300, height: 300)


Image("Example")
.frame(width: 300, height: 300)
.clipped()


//When it comes to the “how should it be applied” part, SwiftUI calls this the content mode and gives us two options: .fit means the entire image will fit inside the container even if that means leaving some parts of the view empty, and .fill means the view will have no empty parts even if that means some of our image lies outside the container.

Image("Example")
.resizable()
.aspectRatio(contentMode: .fit)
.frame(width: 300, height: 300)

Image("Example")
.resizable()
.aspectRatio(contentMode: .fill)
.frame(width: 300, height: 300)



VStack {
    GeometryReader { geo in
        Image("Example")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width, height: 300)
    }
}

//We can even take away height


VStack {
    GeometryReader { geo in
        Image("Example")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width)
    }
}

// How ScrollView lets us work with scrolling data

ScrollView(.vertical) {
    VStack(spacing: 10) {
        ForEach(0..<100) {
            Text("Item \($0)")
                .font(.title)
        }
    }
}


//Full screen

ScrollView(.vertical) {
    VStack(spacing: 10) {
        ForEach(0..<100) {
            Text("Item \($0)")
                .font(.title)
        }
    }
    .frame(maxWidth: .infinity)
}


//Load only will scroll
List {
    ForEach(0..<100) {
        CustomText("Item \($0)")
            .font(.title)
    }
}

//Pushing new views onto the stack using NavigationLink

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello World")
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}


NavigationView {
    VStack {
        NavigationLink(destination: Text("Detail View")) {
            Text("Hello World")
        }
    }
    .navigationBarTitle("SwiftUI")
}


//So, both sheet() and NavigationLink allow us to show a new view from the current one, but the way they do it is different and you should choose them carefully:
//
//1. NavigationLink is for showing details about the user’s selection, like you’re digging deeper into a topic.
//2. sheet() is for showing unrelated content, such as settings or a compose window.

//The most common place you see NavigationLink is with a list, and there SwiftUI does something quite marvelous.


NavigationView {
    List(0..<100) { row in
        NavigationLink(destination: Text("Detail \(row)")) {
            Text("Row \(row)")
        }
    }
    .navigationBarTitle("SwiftUI")
}



struct ContentView: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """

            struct User: Codable {
                var name: String
                var address: Address
            }

            struct Address: Codable {
                var street: String
                var city: String
            }
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

//If you run that program and tap the button you should see the address printed out – although just for the avoidance of doubt I should say that it’s not her actual address!

//There’s no limit to the number of levels Codable will go through – all that matters is that the structs you define match your JSON string.
//
//That brings us to the end of the overview for this project, so please go ahead and reset ContentView.swift to its original state.
