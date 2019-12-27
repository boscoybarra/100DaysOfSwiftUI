import UIKit

//Closures, part two

//Using closures as parameters when they accept parameters

func fetchData(then parse: (String) -> Void) {
    let data = "Success!"
    parse(data)
}
fetchData { (data: String) in
    print("Data received: \(data)")
}

func makePizza(addToppings: (Int)-> Void) {
    print("The dough is ready.")
    print("The base is flat.")
    addToppings(3)
}
makePizza { (toppingCount: Int) in
    let toppings = ["ham", "salami", "onions", "peppers"]
    for i in 0..<toppingCount {
        let topping = toppings[i]
        print("I'm adding \(topping)")
    }
}

func fix(item: String, payBill: (Int) -> Void) {
    print("I've fixed your \(item)")
    payBill(550)
}

fix(item: "roof") { (bill: Int) in
    print("You want $\(bill) for that? Outrageous!")
}

func study(reviseNotes: (String) -> Void) {
    _ = "Napoleon was a short, dead dude."
    let notes2 = "Napoleon was a short."
    for _ in 1...10 {
        reviseNotes(notes2)
    }
}
study { (notes2: String) in
    print("I'm reading my notes: \(notes2)")
}

func getDirections(to destination: String, then travel: ([String]) -> Void) {
    let directions = [
        "Go straight ahead",
        "Turn left onto Station Road",
        "Turn right onto High Street",
        "You have arrived at \(destination)"
    ]
    travel(directions)
}
getDirections(to: "London") { (directions: [String]) in
    print("I'm getting my car.")
    for direction in directions {
        print(direction)
    }
}

func runKidsParty(activities: ([String]) -> Void) {
    let kids = ["Bella", "India", "Phoebe"]
    activities(kids)
}
runKidsParty { (names: [String]) in
    for name in names {
        print("Here's your party bag, \(name).")
    }
}

func getMeasurement(handler: (Double) -> Void) {
    let measurement = 32.2
    handler(measurement)
}
getMeasurement { (measurement: Double) in
    print("It measures \(measurement).")
}

func makeSale(signContract: (String) -> Void) {
    let clientName = "Apple"
    print("\(clientName) should buy our product.")
    print("You're interested? Great! Sign here.")
    signContract(clientName)
}
makeSale { (client: String) in
    print("We agree to pay you $100 million.")
    print("Signed, \(client)")
}

func processPrimes(using closure: (Int) -> Void) {
    let primes = [2, 3, 5, 7, 11, 13, 17, 19]
    for prime in primes {
        closure(prime)
    }
}

//The processPrimes closure WAS missing the in keyword after its parameter list.
processPrimes { (prime: Int) in
    print("\(prime) is a prime number.")
    let square = prime * prime
    print("\(prime) squared is \(square)")
}

//Using closures as parameters when they return values

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}


func playSong(_ name: String, notes: () -> String) {
    print("I'm going to play \(name).")
    let playedNotes = notes()
    print(playedNotes)
}
playSong("Mary Had a Little Lamb") {
    return "EDCDEEEDDDEGG"
}

func activateAI(_ ai: () -> String) {
    print("Let's see what this thing can do...")
    let result = ai()
    print(result)
}
activateAI {
    return "Come with me if you want to live."
}

func playMusic(randomizer: () -> String) {
    print("\(randomizer()) is playing.")
}
playMusic {
    print("Sorry, I only have one playlist!")
    return "Taylor Swift"
}

func loadData(input: () -> String) {
    print("Loading...")
    let str = input()
    print("Loaded: \(str)")
}
loadData {
    return "He thrusts his fists against the posts"
}


// 🤯🤯🤯🤯🤯
func manipulate(numbers: [Int], using algorithm: (Int) -> Int) {
    for number in numbers {
        let result = algorithm(number)
        print("Manipulating \(number) produced \(result)")
    }
}
manipulate(numbers: [1, 2, 3]) { number in
    return number * number
}

func encrypt(password: String, using algorithm: (String) -> String) {
    print("Encrypting password...")
    let result = algorithm(password)
    print("The result is \(result)")
}

encrypt(password: "t4ylor") { (password: String) in
    print("Using top secret encryption!")
    return "SECRET" + password + "SECRET"
}

func scoreToGrade(score: Int, gradeMapping: (Int) -> String) {
    print("Your score was \(score)%.")
    let result = gradeMapping(score)
    print("That's a \(result).")
}
scoreToGrade(score: 90) { (grade: Int) in
    if grade < 85 {
        return "Fail"
    }
    return "Pass"
}


func teachLesson(name: String, topic: () -> String) {
    print("Welcome to \(name).")
    print("Please take out your laptops and be quiet at the back.")
    topic()
    print("See you tomorrow!")
}

teachLesson(name: "Swift 101") {
    return "Swift is a modern language that can be used to make apps on iOS and more."
    
}

func increaseBankBalance(start: Double, interestCalculator: () -> Double) {
    print("Your current balance is \(start).")
    let interestRate = interestCalculator()
    let withInterest = start * interestRate
    print("You now have \(withInterest).")
}

increaseBankBalance(start: 200.0) {
    return 1.01
}

func bakeCookies(number: Int, secretIngredient: () -> String) {
    for _ in 0..<number {
        print("Adding butter...")
        print("Adding flour...")
        print("Adding sugar...")
        print("Adding egg...")
        let extra = secretIngredient()
        print(extra)
    }
}
//The call to bakeCookies() is missing the number parameter label.
//bakeCookies(5) {
//    return "Adding vanilla extract"
//}

bakeCookies(number: 5) {
    return "Adding vanilla extract"
}


// This does not pass in a parameter when calling usernameLoader.
//func printGreeting(for usernameLoader: (String) -> String) {
//    let username = usernameLoader()
//    print("Hello, \(username)!")
//}
//printGreeting {
//    return "twostraws"
//}


//Shorthand parameter names

func travelShort(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travelShort { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

//However, Swift knows the parameter to that closure must be a string, so we can remove it:
travelShort { place -> String in
    return "I'm going to \(place) in my car"
}

//It also knows the closure must return a string, so we can remove that:
travelShort { place in
    return "I'm going to \(place) in my car"
}

//As the closure only has one line of code that must be the one that returns the value, so Swift lets us remove the return keyword too:
travelShort { place in
    "I'm going to \(place) in my car"
}

//Swift has a shorthand syntax that lets you go even shorter. Rather than writing place in we can let Swift provide automatic names for the closure’s parameters. These are named with a dollar sign, then a number counting from 0.
travelShort {
    "I'm going to \($0) in my car"
}

//Shorthand parameters are written as $0, $1 and so on.
//When using shorthand parameters you don't list the parameters you accept.



//Closures with multiple parameters

func travelShortTwoParameters(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travelShortTwoParameters {
    "I'm going to \($0) at \($1) miles per hour."
}

//Returning closures from functions

func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

//We can now call travel() to get back that closure, then call it as a function:

let result = travel()
result("London")

//It’s technically allowable – although really not recommended! – to call the return value from travel() directly:
let result2 = travel()("London")

//Capturing values
func travelCaptureValue() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

//We can call travel() to get back the closure, then call that closure freely:

let resultCaptureValue = travelCaptureValue()
resultCaptureValue("London")

//Closure capturing happens if we create values in travel() that get used inside the closure. For example, we might want to track how often the returned closure is called:

func travelCaptureValues() -> (String) -> Void {
    var counter = 1

    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

let resultCaptureValues = travelCaptureValues()
resultCaptureValues("London")

resultCaptureValues("London")
resultCaptureValues("London")
resultCaptureValues("London")

//You’ve made it to the end of the sixth part of this series, so let’s summarize:

//1. You can assign closures to variables, then call them later on.
//2. Closures can accept parameters and return values, like regular functions.
//3. You can pass closures into functions as parameters, and those closures can have parameters of their own and a return value.
//4. If the last parameter to your function is a closure, you can use trailing closure syntax.
//5. Swift automatically provides shorthand parameter names like $0 and $1, but not everyone uses them.
//6. If you use external values inside your closures, they will be captured so the closure can refer to them later.






