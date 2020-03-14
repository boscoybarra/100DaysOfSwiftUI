import UIKit

var str = "Hello, playground"


// Notes


//Reading custom values from the environment with @EnvironmentObject

//You’ve seen how @State is used to work with state that is local to a single view, and how @ObservedObject lets us pass one object from view to view so we can share it. Well, @EnvironmentObject takes that one step further: we can place an object into the environment so that any child view can automatically have access to it.

//Imagine we had multiple views in an app, all lined up in a chain: view A shows view B, view B shows view C, C shows D, and D shows E. View A and E both want to access the same object, but to get from A to E you need to go through B, C, and D, and they don’t care about that object. If we were using @ObservedObject we’d need to pass our object from each view to the next until it finally reached view E where it could be used, which is annoying because B, C, and D don’t care about it. With @EnvironmentObject view A can put the object into the environment, view E can read the object out from the environment, and views B, C, and D don’t have to know anything happened – it’s much nicer.


class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    let user = User()

    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}



//Creating tabs with TabView and tabItem()


//At a deeper level, it also breaks apart one of the core SwiftUI concepts: that we should be able to compose views freely. If tab 1 was the second item in the array, then:

//Tab 0 is the first tab.
//Tab 1 is the second tab.
//Tab 0 has an onTapGesture() that shows tab 1.
//Therefore tab 0 has intimate knowledge of how its parent, the TabView, is configured.
//This is A Very Bad Idea, and so SwiftUI offers a better solution: we can attach a unique identifier to each view, and use that for the selected tab. These identifiers are called tags, and are attached using the tag() modifier like this:

Text("Tab 2")
.tabItem {
    Image(systemName: "star.fill")
    Text("Two")
}
.tag(1)


//Of course, just using 0 and 1 isn’t ideal – those values are fixed and so it solves the problem of views being moved around, but they aren’t easy to remember. Fortunately, you can use strings instead: give each view a string tag that is unique and reflects its purpose, then use that for your @State property. This is much easier to work with in the long term, and is recommended over integers.

//Tip: It’s common to want to use NavigationView and TabView at the same time, but you should be careful: TabView should be the parent view, with the tabs inside it having a NavigationView as necessary, rather than the other way around.


struct ContentView: View {
    
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
            .onTapGesture {
                self.selectedTab = 1
            }
            .tabItem {
                Image(systemName: "star")
                Text("One")
            }
            .tag(0)

            Text("Tab 2")
            .tabItem {
                Image(systemName: "star.fill")
                Text("Two")
            }
            .tag(1)
        }
    }
}




//Swift’s Result type is designed to solve the problem when you know thing A might be true or thing B might be true, but exactly one can be true at any given time. If you imagine those as Boolean properties, then each has two states (true and false), but together they have four states:
//
//A is false and B is false
//A is true and B is false
//A is false and B is true
//A is true and B is true
//If you know for sure that options 1 and 4 are never possible – that either A or B must be true but they can’t both be true – then you can immediately halve the complexity of your logic.


//There is one small complexity here, and although I’ve mentioned it briefly before now it becomes important. When we pass a closure into a function, Swift needs to know whether it will be used immediately or whether it might be used later on. If it’s used immediately – the default – then Swift is happy to just run the closure. But if it’s used later on, then it’s possible whatever created the closure has been destroyed and no longer exists in memory, in which case the closure would also be destroyed and can no longer be run.

//To fix this, Swift lets us mark closure parameters as @escaping, which means “this closure might be used outside of the current run of this method, so please keep its memory alive until we’re done.”


//Understanding Swift’s Result type

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View {

    var body: some View {
        Text("Hello, World!")
        .onAppear {
            self.fetchData(from: "https://www.apple.com") { result in
                switch result {
                case .success(let str):
                    print(str)
                case .failure(let error):
                    switch error {
                    case .badURL:
                        print("Bad URL")
                    case .requestFailed:
                        print("Network problems")
                    case .unknown:
                        print("Unknown error")
                    }
                }
            }
        }
    }
    
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        // check the URL is OK, otherwise return with a failure
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // the task has completed – push our work back to the main thread
            DispatchQueue.main.async {
                if let data = data {
                    // success: convert the data to a string and send it back
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    // any sort of network failure
                    completion(.failure(.requestFailed))
                } else {
                    // this ought not to be possible, yet here we are
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}


//Manually publishing ObservableObject changes

//DispatchQueue.main.async() as a way of pushing work to the main thread, but here we’re going to use a similar method called DispatchQueue.main.asyncAfter(). This lets us specify when the attached closure should be run, which means we can say “do this work after 1 second” rather than “do this work now.”


class DelayedUpdater: ObservableObject {
//    if you remove the @Published property wrapper you’ll see the UI no longer changes. Behind the scenes all the asyncAfter() work is still happening, but it doesn’t cause the UI to refresh any more because no change notifications are being sent out.
//    @Published var value = 0
    
    var value = 0 {
        willSet {
//            by sending the change notifications manually using the objectWillChange property I mentioned earlier. This lets us send the change notification whenever we want, rather than relying on @Published to do it automatically.
            objectWillChange.send()
        }
    }
    
//    Now you’ll get the old behavior back again – the UI will count to 10 as before. Except this time we have the opportunity to add extra functionality inside that willSet observer. Perhaps you want to log something, perhaps you want to call another method, or perhaps you want to clamp the integer inside value so it never goes outside of a range – it’s all under our control now.
    

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}


struct ContentView: View {
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

//Controlling image interpolation in SwiftUI

struct ContentView: View {

    var body: some View {
        Image("example")
//            SwiftUI gives us the interpolation() modifier that lets us control how pixel blending is applied./
        .interpolation(.none)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}


//Creating context menus

struct ContentView: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
//             SwiftUI lets us attach context menus to objects to provide this extra functionality, all done using the contextMenu() modifier.
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.red)
                    }

                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                    }

                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                        Text("Blue")
                    }
                }
        }
    }
}


//Scheduling local notifications

struct ContentView: View {

    var body: some View {
        VStack {
            Button("Request Permission") {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
               let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

//Adding Swift package dependencies in Xcode


//The reason this is possible is because most developers have agreed a system of semantic versioning (SemVer) for their code. If you look at a version like 1.5.3, then the 1 is considered the major number, the 5 is considered the minor number, and the 3 is considered the patch number. If developers follow SemVer correctly, then they should:

//Change the patch number when fixing a bug as long as it doesn’t break any APIs or add features.
//Change the minor number when they added features that don’t break any APIs.
//Change the major number when they do break APIs.



struct ContentView: View {
    let possibleNumbers = Array(1...60)
    
    var results: String {
//        Inside there we’re going to select seven random numbers from our range, which can be done using the extension you got from my SamplePackage framework. This provides a random() method that accepts an integer and will return up to that number of random elements from your sequence, in a random order. Lottery numbers are usually arranged from smallest to largest, so we’re going to sort them.
        let selected = possibleNumbers.random(7).sorted()
//        Next, we need to convert that array of integers into strings. This only takes one line of code in Swift, because sequences have a map() method that lets us convert an array of one type into an array of another type by applying a function to each element. In our case, we want to initialize a new string from each integer, so we can use String.init as the function we want to call.
        let strings = selected.map(String.init)
//        At this point strings is an array of strings containing the seven random numbers from our range, so the last step is to join them all together with commas in between. Add this final line to the property now:
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}

//Sharing data across tabs using @EnvironmentObject

//SwiftUI’s environment lets us share data in a really beautiful way: any view can send objects into the environment, then any child view can read those objects back out from the environment at a later date. Even better, if one view changes the object all other views automatically get updated – it’s an incredibly smart way to share data in larger applications.

