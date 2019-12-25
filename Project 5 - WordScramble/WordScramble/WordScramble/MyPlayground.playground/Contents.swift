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


let input = "a b c"
let letters = input.components(separatedBy: " ")

//

let input = """
            a
            b
            c
            """
let letters = input.components(separatedBy: "\n")

//

//For example, this will read a random letter from our array:
let letter = letters.randomElement()


//This behavior is so common it’s built right into the CharacterSet struct, so we can ask Swift to trim all whitespace at the start and end of a string like this:
let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)


//Checking a string for misspelled words takes four steps in total. First, we create a word to check and an instance of UITextChecker that we can use to check that string:

let word = "swift"
let checker = UITextChecker()

//However, there’s a catch: Swift uses a very clever, very advanced way of working with strings, which allows it to use complex characters such as emoji in exactly the same way that it uses the English alphabet. However, Objective-C does not use this method of storing letters, which means we need to ask Swift to create an Objective-C string range using the entire length of all our characters, like this:

let range = NSRange(location: 0, length: word.utf16.count)

//UTF-16 is what’s called a character encoding – a way of storing letters in a string. We use it here so that Objective-C can understand how Swift’s strings are stored; it’s a nice bridging format for us to connect the two.


let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
//That sends back another Objective-C string range, telling us where the misspelling was found. Even then, there’s still one complexity here: Objective-C didn’t have any concept of optionals, so instead relied on special values to represent missing data.

//In this instance, if the Objective-C range comes back as empty – i.e., if there was no spelling mistake because the string was spelled correctly – then we get back the special value NSNotFound.


//So, we could check our spelling result to see whether there was a mistake or not like this:
let allGood = misspelledRange.location == NSNotFound




struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        
        List {
            ForEach(people, id: \.self) {
                Text($0)
            }
        }
    }
}
