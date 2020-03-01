import UIKit

var str = "Hello, playground"


//Identifying views with useful labels

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]

    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
//          This allows VoiceOver to read the correct label no matter what image is present. Of course, if your image wasn’t randomly changing you could just type your label directly into the modifier.
            .accessibility(label: Text(labels[selectedPicture]))
//            This lets us provide some extra behind the scenes information to VoiceOver that describes how the view works, and in our case we can tell it that our image is also a button by adding this modifier:
            .accessibility(addTraits: .isButton)
//            This is self-evidently true, but it’s also not helpful because we’ve attached a tap gesture to it so it’s effectively a button.  you could remove the image trait as well, because it isn’t really adding much:
            .accessibility(removeTraits: .isImage)
            .onTapGesture {
                self.selectedPicture = Int.random(in: 0...3)
            }
    }
}

//Hiding and grouping accessibility data

struct ContentView: View {

    var body: some View {
//        Whether it’s a simple bullet point or an animation of your app’s mascot character running around, it doesn’t actually convey any information and so Image(decorative:) tells SwiftUI it should be ignored by VoiceOver.
        Image(decorative: "character")
//     With that modifier the image becomes invisible to VoiceOver regardless of what traits it has.
        .accessibility(hidden: true)
        
        
//        VoiceOver sees that as two unrelated text views, and so it will either read “Your score is” or “1000” depending on what the user has selected.
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
//        This reads the text together BUT adds a small silene between each information
//        .accessibilityElement(children: .combine)
//        On the other had we ignore the childre Text BUT we tell VoiceOver to read it with the label tag
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("Your score is 1000"))
        
        
    }
}


//Reading the value of controls

struct ContentView: View {

    @State private var rating = 3

    var body: some View {
        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
//     When that runs, at least right now, you can select the stepper and swipe up or down to change the value, but VoiceOver won’t read out the values as they change. We can fix this by adding a custom read out for the values, like this:
        .accessibility(value: Text("\(rating) out of 5"))
    }
}

struct ContentView: View {

    @State private var estimate = 25.0

    var body: some View {
        Slider(value: $estimate, in: 0...50)
            .padding()
//            VoiceOver reads values as percentages, which makes no sense. To fix this, we can use the accessibility(value:) modifier to provide custom text
//            This is particularly important in places where SwiftUI doesn’t do a great job of updating the UI as values change. We help Voice Over know this shouldnt be read as %.
            .accessibility(value: Text("\(Int(estimate))"))
    }
}
