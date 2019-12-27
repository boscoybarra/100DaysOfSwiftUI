import UIKit
  
//Closures, part one

//* Their syntax can hurt your brain, and even explanations of their syntax can hurt your brain. For example, if a closure returns an integer, and you write a function that returns that closure, then you might read something like “this function returns a closure that returns an integer.” Yeah, I know – it’s hard.
//* If values used inside a closure were created outside the closure then Swift will make sure they remain available for the life of the closure so you don’t accidentally try to read something that doesn’t exist any more.

let driving = {
    print("I'm driving in my car")
}

driving()

let running = {
    2 * 2
}

running()

//Unlike functions, closures put their parameters inside the opening brace.
//var signAutograph(to name: String) = {
//    print("To \(name), my #1 fan")
//}
//signAutograph(to: "Lisa")


//Accepting parameters in a closure

//To make a closure accept parameters, list them inside parentheses just after the opening brace, then write in so that Swift knows the main body of the closure is starting.

let drivingTo = { (place: String) in
    print("I'm going to \(place) in my car")
}


drivingTo("London")

var runningTo = { (to: String) in
    print("I'm running to \(to) with my own feet")
}

runningTo("Monte Igeldo")

var sendMessage = { (message: String) in
    if message != "" {
        print("Sending to Twitter: \(message)")
    } else {
        print("Your message was empty.")
    }
}

var pickFruit = { (name: String) in
    switch name {
    case "strawberry":
        print("Strawberries and raspberries are half price!")
    case "raspberry":
        print("Strawberries and raspberries are half price!")
    default:
        print("We don't have those.")
    }
}

pickFruit("strawberry")


//Swift is unable to figure out what type of data answer is.

//let calculateResult = { (answer) in
//    if answer == 42 {
//        print("You're correct!")
//    } else {
//        print("Try again.")
//    }
//}

//var cutGrass = { (length currentLength: Double) in
//    switch currentLength {
//    case 0...1:
//        print("That's too short")
//    case 1...3:
//        print("It's already the right length")
//    default:
//        print("That's perfect.")
//    }
//}

//Closures cannot use external parameter labels.
//Closures cannot use external parameter labels.
//Closures cannot use external parameter labels.

let rowBoat = { (distance: Int) in
    for _ in 1...distance {
        print("I'm rowing 1km.")
    }
}
rowBoat(5)

//Returning values from a closure

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)

var flyDrone = { (hasPermit: Bool) -> Bool in
    if hasPermit {
        print("Let's find somewhere safe!")
        return true
    }
    print("That's against the law.")
    return false
}

let measureSize = { (inches: Int) -> String in
    switch inches {
    case 0...26:
        return "XS"
    case 27...30:
        return "S"
    case 31...34:
        return "M"
    case 35...38:
        return "L"
    default:
        return "XL"
    }
}
measureSize(36)

var difficultyRating = { (trick: String) -> Int in
    if trick == "ollie" {
        return 1
    } else if trick == "Yoyo Plant" {
        return 3
    } else if trick == "900" {
        return 5
    } else {
        return 0
    }
}
print(difficultyRating("ollie"))

//Closures as parameters

let drivingTestTest = {
    print("I'm driving in my car")
}

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving)

let awesomeTalk = {
    print("Here's a great talk!")
}
func deliverTalk(name: String, type: () -> Void) {
    print("My talk is called \(name)")
    type()
}
deliverTalk(name: "My Awesome Talk", type: awesomeTalk)

let swanDive = {
    print("SWAN DIVE!")
}
func performDive(type dive: () -> Void) {
    print("I'm climbing up to the top")
    dive()
}
performDive(type: swanDive)

var payCash = {
    print("Here's the money.")
}
func buyClothes(item: String, using payment: () -> Void) {
    print("I'll take this \(item).")
    payment()
}
buyClothes(item: "jacket", using: payCash)


let driveSafely = {
    return "I'm being a considerate driver"
}

// cannot convert value of type '() -> String' to expected argument type '() -> Void'
//drive(using: driveSafely)

//
//func drive(using driving: () -> Void) {
//    print("Let's get in the car")
//    driving()
//    print("We're there!")
//}
//drive(using: driveSafely)

//drive() says its parameter must be a closure that accepts no parameters and returns nothing, but the closure it is given returns a string.

let driveSafelyString = {
    return "I'm being a considerate driver"
}

let drivingWith = {
    print("Cybertrucking!")
}

func driveString(using driving: () -> String) {
    print("Let's get in the car")
    drivingWith()
    print("We're there!")
}
driveString(using: driveSafelyString)


//Trailing closure syntax

func travelToSomewhere(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

//travelToSomewhere() {
//    print("I'm driving in my car")
//}

//In fact, because there aren’t any other parameters, we can eliminate the parentheses entirely:
travelToSomewhere {
    print("I'm driving in my car")
}


func holdClass(name: String, lesson: () -> Void) {
    print("Welcome to \(name)!")
    lesson()
    print("Make sure your homework is done by next week.")
}

holdClass(name:"Philosophy 101") {
    print("All we are is dust in the wind, dude.")
}

func phoneFriend(conversation: () -> Void) {
    print("Calling 555-1234...")
    conversation()
}

let conversation = {
    phoneFriend
    print("Hello!")
    print("A foreign prince wants to give you $5 million.")
    print("What are your bank details?")
}

func tendGarden(activities: () -> Void) {
    print("I love gardening")
    activities()
}
tendGarden {
    print("Let's grow some roses!")
}

func makeCake(instructions: () -> Void) {
    print("Wash hands")
    print("Collect ingredients")
    instructions()
    print("Here's your cake!")
}
makeCake {
    print("Mix egg and flour")
}


//func brewTea(steps: ()) {
//    print("Get tea")
//    print("Get milk")
//    print("Get sugar")
//    steps()
//}
//brewTea {
//    print("Brew tea in teapot.")
//    print("Add milk to cup")
//    print("Pour tea into cup")
//    print("Add sugar to taste.")
//}

//The steps parameter is defined as an empty tuple, not a closure.

func repeatAction(count: Int, action: () -> Void) {
    for _ in 0..<count {
        action()
    }
}
repeatAction(count: 5) {
    print("Hello, world!")
}

func goCamping(then action: () -> Void) {
    print("We're going camping!")
    action()
}
goCamping {
    print("Sing songs")
    print("Put up tent")
    print("Attempt to sleep")
}

func goOnVacation(to destination: String, _ activities: () -> Void) {
    print("Packing bags...")
    print("Getting on plane to \(destination)...")
    activities()
    print("Time to go home!")
}
goOnVacation(to: "Mexico") {
    print("Go sightseeing")
    print("Relax in sun")
    print("Go hiking")
}
