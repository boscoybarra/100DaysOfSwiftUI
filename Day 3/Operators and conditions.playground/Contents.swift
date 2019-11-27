import UIKit

//Arithmetic operators
//For example, we set secondScore to 4, so if we say 13 % secondScore we’ll get back one, because 4 fits into 13 three times with remainder one:

var result = 11 % 6
//11 divides into 6 once, leaving remainder 5.

//let result = 10 / 2.0
//This will create a double, not an integer.

//Remember, Swift is a type-safe language, which means it won’t let you mix types. For example, you can’t add an integer to a string because it doesn’t make any sense.

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

//let result = ["name": "Paul"] + ["Hudson"]
//Correct! This attempts to add an array to a dictionary.

//let result = false + false
//Oops – that's not correct. You can't perform addition using Booleans.

//var result = 3 ** 8
//Oops – that's not correct. ** is not a built-in operator in Swift.


//Conditions

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}

//You can use && and || more than once in a single condition, but don’t make things too complicated otherwise it can be hard to read!


let loggedIn = true
let authorized = false

if loggedIn && authorized {
    print("Hello, Swift!")
}
//Oops – that's not correct. Although loggedIn is true authorized is not, and && requires both sides to be true.

//MARK: Ternary operator
// Ternary operator

let firstCard = 11
let secondCard = 10
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

//That checks whether the two cards are the same, then prints “Cards are the same” if the condition is true, or “Cards are different” if it’s false. We could write the same code using a regular condition:

if firstCard == secondCard {
    print("Cards are the same")
} else {
    print("Cards are different")
}


let strongMagnets = true
print(strongMagnets ? "Success" : "Failure")
//Oops – that's not correct. Because strongMagnets is true, this will print "Success".

//var singers = ["Taylor Swift"]
//print(singers == "Taylor Swift" ? "Success" : "Failure")

//Oops – that's not correct. This attempts to compare a string and an array of strings, which is invalid.


//Switch statements

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}

//Swift will only run the code inside each case. If you want execution to continue on to the next case, use the fallthrough keyword like this:

//switch weather {
//case "rain":
//    print("Bring an umbrella")
//case "snow":
//    print("Wrap up warm")
//case "sunny":
//    print("Wear sunscreen")
//    fallthrough
//default:
//    print("Enjoy your day!")
//}


//Range operators
//Swift gives us two ways of making ranges: the ..< and ... operators. The half-open range operator, ..<, creates ranges up to but excluding the final value, and the closed range operator, ..., creates ranges up to and including the final value.
//
//For example, the range 1..<5 contains the numbers 1, 2, 3, and 4, whereas the range 1...5 contains the numbers 1, 2, 3, 4, and 5.

let score = 85

switch score {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}

//You’ve made it to the end of the third part of this series, so let’s summarize:
//
//1. Swift has operators for doing arithmetic and for comparison; they mostly work like you already know.
//2. There are compound variants of arithmetic operators that modify their variables in place: +=, -=, and so on.
//3. You can use if, else, and else if to run code based on the result of a condition.
//4. Swift has a ternary operator that combines a check with true and false code blocks. Although you might see it in other code, I wouldn’t recommend using it yourself.
//5. If you have multiple conditions using the same value, it’s often clearer to use switch instead.
//6. You can make ranges using ..< and ... depending on whether the last number should be excluded or included.

