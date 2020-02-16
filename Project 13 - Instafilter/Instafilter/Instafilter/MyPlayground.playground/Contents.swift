import UIKit

var str = "Hello, playground"


struct ContentView: View {
    
//    Now let’s go a stage further: you’ve just seen how State wraps its value using a non-mutating setter, which means neither blurAmount or the State struct wrapping it are changing – our binding is directly changing the internally stored value, which means the property observer is never being triggered.

//How then can we solve this – how can we attach some functionality to a wrapped property? For that we need custom bindings – let’s look at that next…
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)
        }
    }
}


//Creating custom bindings in SwiftUI

//KEY:  if you want to make sure you update UserDefaults every time a value is changed, the set closure of a Binding is perfect.

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
//          Inside de value we pass here "blur" is the only thing that changes
            Slider(value: blur, in: 0...20)
        }
    }
}


//Showing multiple options with ActionSheet


