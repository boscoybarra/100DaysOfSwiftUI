import UIKit

var str = "Hello, playground"


Text("Hello World")
.padding()
.background(Color.red)
.padding()
.background(Color.blue)
.padding()
.background(Color.green)
.padding()
.background(Color.yellow)

//The best way to think about it for now is to imagine that SwiftUI renders your view after every single modifier. So, as soon as you say .background(Color.red) it colors the background in red, regardless of what frame you give it. If you then later expand the frame, it won’t magically redraw the background – that was already applied.
//
//Of course, this isn’t actually how SwiftUI works, because if it did it would be a performance nightmare, but it’s a neat mental shortcut to use while you’re learning.

struct ContentView: View {
    
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            self.useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}


//Swift doesn’t let us create one stored property that refers to other stored properties, because it would cause problems when the object is created. This means trying to create a TextField bound to a local property will cause problems.

//However, you can create computed properties if you want, like this:

struct ContentView: View {
    var motto1: some View { Text("Draco dormiens") }
//    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    var body: some View {
        VStack {
            motto1
            motto2
        }
    }
}

//View composition

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
        }
    }
}

VStack(spacing: 10) {
    CapsuleText(text: "First")
        .foregroundColor(.white)
    CapsuleText(text: "Second")
        .foregroundColor(.yellow)
}

//Custom modifiers

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

//We can now use that with the modifier() modifier – yes, it’s a modifier called “modifier”, but it lets us apply any sort of modifier to a view, like this:


struct ContentView: View {
    var body: some View {
        Text("Hello World")
        .modifier(Title())
    }
}


//When working with custom modifiers, it’s usually a smart idea to create extensions on View that make them easier to use. For example, we might wrap the Title modifier in an extension such as this:

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

//We can now use the modifier like this:

struct ContentView: View {
    var body: some View {
        Text("Hello World")
        .titleStyle()
    }
}


//Custom modifiers can do much more than just apply other existing modifiers – they can also create new view structure, as needed. Remember, modifiers return new objects rather than modifying existing ones, so we could create one that embeds the view in a stack and adds another view:

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

//With that in place, we can now add a watermark to any view like this:

Color.blue
.frame(width: 300, height: 200)
.watermarked(with: "Hacking with Swift")
