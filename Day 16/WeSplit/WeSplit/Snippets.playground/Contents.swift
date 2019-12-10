import UIKit

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = 0

    var body: some View {
        VStack {
            Picker("Select your student", selection: $selectedStudent) {
                ForEach(0 ..< students.count) {
                    Text(self.students[$0])
                }
            }
            Text("You chose: Student # \(students[selectedStudent])")
        }
    }
}

//1. The students array doesn’t need to be marked with @State because it’s a constant; it isn’t going to change.
//2. The selectedStudent property starts with the value 0 but can change, which is why it’s marked with @State.
//3. The Picker has a label, “Select your student”, which tells users what it does and also provides something descriptive for screen readers to read aloud.
//4. The Picker has a two-way binding to selectedStudent, which means it will start showing a selection of 0 but update the property as the user moves the picker.
//5. Inside the ForEach we count from 0 up to (but excluding) the number of students in our array.
//6. For each student we create one text view, showing that student’s name.


struct ContentView: View {
    //    Tip: There are several ways of storing program state in SwiftUI, and you’ll learn all of them. @State is specifically designed for simple properties that are stored in one view. As a result, Apple recommends we add private access control to those properties, like this: @State private var tapCount = 0.
//    @State private var tapCount = 0
    @State private var name = ""

    var body: some View {
        Form {

//  $name :This tells Swift that it should read the value of the property but also write it back as any changes happen.
            TextField("Enter your name", text: $name)
//  Notice how that uses name rather than $name? That’s because we don’t want a two-way binding here – we want to read the value, yes, but we don’t want to write it back somehow, because that text view won’t change.
            Text("Your name is \(name)")
            
//        ForEach(0 ..< 100) { number in
//            Text("Row \(number)")
            ForEach(0 ..< 100) {
                Text("Row \($0)")
            }
        }
        
//        Button("Tap Count: \(tapCount)") {
//            self.tapCount += 1
//        }
    }
}
