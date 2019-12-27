import UIKit

//Creating your own structs

struct SportFirst {
    var name: String
}

var tennis = SportFirst(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn tennis"

print(tennis.name)

//

struct Order {
    var customerID: Int
    var itemID: Int
}
let order = Order(customerID: 143, itemID: 556)
print(order.customerID)


struct User {
    var name = "Anonymous"
    var age: Int
}
let twostraws = User(name: "Paul", age: 38)

struct Cup {
    var size: Int
    var color = "White"
}

//

//Computed properties

struct Sport {
    var name: String
    var isOlympicSport: Bool

//Computed properties must always have an explicit type.
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

//

struct Wine {
    var age: Int
    var isVintage: Bool
    var price: Int {
        if isVintage {
            return age + 20
        } else {
            return age + 5
        }
    }
}
let malbec = Wine(age: 2, isVintage: true)
print(malbec.price)



struct Dog {
    var breed: String
    var cuteness: Int
    var rating: String {
        if cuteness < 3 {
            return "That's a cute dog!"
        } else if cuteness < 7 {
            return "That's a really cute dog!"
        } else {
            return "That a super cute dog!"
        }
    }
}

let luna = Dog(breed: "Samoyed", cuteness: 11)
print(luna.rating)


struct Swordfighter {
    var name: String
    var introduction: String {
        return "Hello, my name is \(name)."
    }
}

let inigo = Swordfighter(name: "Inigo Montoya")


//Property observers

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}
//What we want to happen is for Swift to print a message every time amount changes, and we can use a didSet property observer for that. This will run some code every time amount changes:

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

//You can also use willSet to take action before a property changes, but that is rarely used.

struct BankAccount {
    var name: String
    var isMillionnaire = false
    var balance: Int {
        didSet {
            if balance > 1_000_000 {
                isMillionnaire = true
            } else {
                isMillionnaire = false
            }
        }
    }
}

struct App {
    var name: String
    var isOnSale: Bool {
        didSet {
            if isOnSale {
                print("Go and download my app!")
            } else {
                print("Maybe download it later.")
            }
        }
    }
}

//NOTE: You can't attach a property observer to a constant, because it will never change.

//Methods

struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}


let london = City(population: 9_000_000)
london.collectTaxes()


struct Desk {
    var isAdjustable: Bool
    func adjust(to newHeight: Int) {
        if isAdjustable {
            print("Adjusting now...")
        } else {
            print("That isn't possible.")
        }
    }
}

let desk = Desk(isAdjustable: true)

desk.adjust(to: 10)

struct Venue {
    var name: String
    var maximumCapacity: Int
    func makeBooking(for people: Int) {
        if people > maximumCapacity {
            print("Sorry, we can only accommodate \(maximumCapacity).")
        } else {
            print("\(name) is all yours!")
        }
    }
}


struct UserAddress {
    var name: String
    var street: String
    var city: String
    var postalCode: String
    func printAddress() -> String {
        return """
        \(name)
        \(street)
        \(city)
        \(postalCode)
        """
    }
}

let user = UserAddress(name: "Juan", street: "Street X", city: "Somewhere", postalCode: "0000")
user.city

//Mutating methods

// By default Swift won’t let you write methods that change properties unless you specifically request it.
struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()

struct Diary {
    var entries: String
    mutating func add(entry: String) {
        entries += "\(entry)"
    }
}


// The staple() method modifies a struct's property without being marked mutating.

//struct Stapler {
//    var stapleCount: Int
//    func staple() {
//        if stapleCount > 0 {
//            stapleCount -= 1
//            print("It's stapled!")
//        } else {
//            print("Please refill me.")
//        }
//    }
//}


struct Tree {
    var height: Double
    mutating func grow() {
        height *= 1.001
    }
}
//mileage is declared as a constant, so it can't be changed.

//struct Car {
//    let mileage: Int
//    mutating func drive(distance: Int) {
//        mileage += distance
//    }
//}

struct Book {
    var totalPages: Int
    var pagesLeftToRead = 0
    mutating func read(pages: Int) {
        if pages < pagesLeftToRead {
            pagesLeftToRead -= pages
        } else {
            pagesLeftToRead = 0
            print("I'm done!")
        }
    }
}

struct BankAccountExample {
    var balance: Int
    mutating func donateToCharity(amount: Int) {
        balance -= amount
    }
}

struct Delorean {
    var speed = 0
    mutating func accelerate() {
        speed += 1
        if speed == 88 {
            travelThroughTime()
        }
    }
    func travelThroughTime() {
        print("Where we're going we don't need roads.")
    }
}


//Properties and methods of strings

let string = "Do or do not, there is no try."

print(string.count)

print(string.hasPrefix("Do"))

print(string.uppercased())

print(string.sorted())

var str = ""
for i in 1...5 {
    str += "\(i)"
}
str.count == 6

var favoriteIceCream = "choc chip"
favoriteIceCream.count > 10

let song = "Shake it Off"
song.uppercased().contains("SHAKE")

//Properties and methods of arrays

var toys = ["Woody"]

print(toys.count)

toys.append("Buzz")

toys.firstIndex(of: "Buzz")

print(toys.sorted())

toys.remove(at: 0)

var fibonacci = [1, 1, 2, 3, 5, 8]
fibonacci.sorted() == [1, 2, 3, 5, 8]


//You can't remove items from a constant array.

//let heights = [1.0, 1.2, 1.15, 1.39]
//heights.remove(at: 0)
//heights.count == 3


let spaceships = ["Serenity", "Enterprise"]
spaceships.contains("Serenity")

var examScores = [100, 95, 92]
examScores.insert(90, at: 1)

//You can't append to a constant array.
//let composers = ["Mozart", "Bach", "Beethoven"]
//composers.append("Chopin")
//composers.count == 4


