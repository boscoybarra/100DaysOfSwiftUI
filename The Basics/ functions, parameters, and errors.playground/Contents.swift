import UIKit

//Functions

func open(gifts: [String]) {
    for gift in gifts {
        print("It's a \(gift) - thank you!")
    }
}
open(gifts: ["guitar", "pair of socks"])


//Returning values

func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)
print(result)

//If you need to return multiple values, this is a perfect example of when to use tuples.

func read(books: [String]) -> Bool {
    for book in books {
        print("I'm reading \(book)")
    }
    return true
}

func writeToLog(message: String) -> Bool {
    if message != "" {
        print("Log: \(message)")
        return true
    } else {
        return false
    }
}

func paintHouse(color: String) -> Bool {
    if color == "tartan" {
    }
    return false
}

func countMultiplesOf10(numbers: [Int]) -> Int {
    var result = 0
    for number in numbers {
        if number % 10 == 0 {
            result += 1
        }
    }
    return result
}
countMultiplesOf10(numbers: [5, 10, 15, 20, 25])

//Parameter labels
func isPassingGrade(for scores: [Int]) -> Bool {
    var total = 0
    for score in scores {
        total += score
    }
    if total >= 500 {
        return true
    } else {
        return false
    }
}

isPassingGrade(for: [1,5])

func drive(to: String) {
    print("I'm going to \(to) in my car.")
}

drive(to: "Zarutz")


//func add(numbers input sum: [Int]) -> Int {
//    var total = 0
//    for number in input {
//        total += number
//    }
//    return total
//}

//add() has three labels for its parameter, which is invalid.


//Omitting parameter labels

func greet(_ person: String) {
    print("Hello, \(person)!")
}

greet("Taylor")

func bounceOnTrampoline(times: Int) {
    for _ in 1...times {
        print("Boing!")
    }
}

func evaluateJavaScript(_ input: String) {
    print("Yup, that's JavaScript alright.")
}

evaluateJavaScript("He")

//Default parameters

func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

//That can be called in two ways:
greet("Taylor")
greet("Taylor", nicely: false)

func calculateWages(payBand: Int, isOvertime: Bool = false) -> Int {
    var pay = 10_000 * payBand
    if isOvertime {
        pay *= 2
    }
    return pay
}
calculateWages(payBand: 5, isOvertime: true)

func runRace(distance: Int = 10) {
    if distance < 5 {
        print("This should be easy!")
    } else if distance < 10 {
        print("This should be a nice challenge.")
    } else {
        print("Let's do this!")
    }
}

func parkCar(_ type: String, automatically: Bool = true) {
    if automatically {
        print("Nice - my \(type) parked itself!")
    } else {
        print("I guess I'll have to do it.")
    }
}
parkCar("Tesla")

//Variadic functions

//Variadic parameters are converted into arrays inside your function.

//You can make any parameter variadic by writing ... after its type. So, an Int parameter is a single integer, whereas Int... is zero or more integers – potentially hundreds.

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5)


func play(games: String...) {
    for game in games {
        print("Let's play \(game)!")
    }
}
play(games: "Chess")

//Writing throwing functions

// by marking them as throws before their return type, then using the throw keyword when something goes wrong.

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

//Instead, you need to call these functions using three new keywords: do starts a section of code that might cause problems, try is used before every function that might throw an error, and catch lets you handle errors gracefully.

//If any errors are thrown inside the do block, execution immediately jumps to the catch block. Let’s try calling checkPassword() with a parameter that throws an error:

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

//checkPassword("password")


enum AgeError: Error {
    case underAge
    case unknownAge
}
func buyAlcohol(age: Int) throws {
    if age >= 18 {
        print("OK.")
    } else {
        throw AgeError.underAge
    }
}


enum PizzaErrors: Error {
    case hasPineapple
}

func makePizza(type: String) throws {
    if type != "Hawaiian" {
        print("Your pizza will be ready in 10 minutes.")
    } else {
        throw PizzaErrors.hasPineapple
    }
}

enum LoginError: Error {
    case unknownUser
}
func authenticate(username: String) throws {
    if username == "Anonymous" {
        throw LoginError.unknownUser
    }
    print("Welcome, \(username)!")
}

//Running throwing functions

// Check checkPassword code and how this works:

//do {
//    try checkPassword("password")
//    print("That password is good!")
//} catch {
//    print("You can't use that password.")
//}

//If any errors are thrown, execution immediately jumps to the catch block.

//" You should mark all functions as throwing."
//There's no need for this – only mark functions as throwing if they throw errors.

//inout parameters

//All parameters passed into a Swift function are constants, so you can’t change them. If you want, you can pass in one or more parameters as inout, which means they can be changed inside your function, and those changes reflect in the original value outside the function.

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 100
doubleInPlace(number: &myNum)

//Test with constant

//func doubleInPlaceTest(number: Int) {
//    number *= 2
//}
//
//var myNumTest = 100
//doubleInPlace(number: myNumTest)

func paintWalls(tastefully: Bool, color: inout String) {
    if tastefully {
        color = "cream"
    } else {
        color = "tartan"
    }
}
// This attempts to pass a constant string into a function as an inout parameter.
//let color = ""
var color = ""
paintWalls(tastefully: true, color: &color)


//Remmeber: Regular parameters are passed into functions as constants.
//inout must be variables

//Functions let us re-use code without repeating ourselves.
//Functions can accept parameters – just tell Swift the type of each parameter.
//Functions can return values, and again you just specify what type will be sent back. Use tuples if you want to return several things.
//You can use different names for parameters externally and internally, or omit the external name entirely.
//Parameters can have default values, which helps you write less code when specific values are common.
//Variadic functions accept zero or more of a specific parameter, and Swift converts the input to an array.
//Functions can throw errors, but you must call them using try and handle errors using catch.
//You can use inout to change variables inside a function, but it’s usually better to return a new value.


