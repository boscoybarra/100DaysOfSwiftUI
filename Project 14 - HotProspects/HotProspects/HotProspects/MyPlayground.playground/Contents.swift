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
