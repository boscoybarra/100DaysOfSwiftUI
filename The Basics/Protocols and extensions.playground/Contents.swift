import UIKit

//Protocols and extensions

//NOTE: Protocols specify what methods and properties conforming types must have.

//Protocols

protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

var display = User(id: "2345")
display.id

protocol Swimmable {
    var depth: Int { get set }
}


//which will require all conforming types to have an id string that can be read (“get”) or written (“set”)
protocol Climbable {
    var height: Double { get }
    var gradient: Int { get }
}

protocol Singable {
    var lyrics: [String] { get set }
    var notes: [String] { get set }
}


//It's not possible to create set-only properties in Swift.

//protocol Buildable {
//    var numberOfBricks: Int { set }
//    var materials: [String] { set }
//}


//Protocol inheritance

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

//

protocol MakesDiagnoses {
    func evaluate(patient: String) -> String
}

protocol PrescribesMedicine {
    func prescribe(drug: String)
}

protocol Doctor: MakesDiagnoses, PrescribesMedicine { }


//Extensions
//Extensions allow you to add methods to existing types, to make them do things they weren’t originally designed to do.
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 7
number.squared()

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

number.isEven


extension Double {
    var isNegative: Bool {
        return self < 0
    }
}

let numberDouble = 2.9
numberDouble.isNegative

//The append() method must be marked mutating.
//extension String {
//    func append(_ other: String) {
//        self += other
//    }
//}

extension Int {
    var isAnswerToLifeUniverseAndEverything: Bool {
        let target = 42
        return self == target
    }
}

extension Bool {
    func toggled() -> Bool {
        if self == true {
            return false
        } else {
            return true
        }
    }
}

extension Int {
    func cubed() -> Int {
        return self * self * self
    }
}

extension Int {
    func clamped(min: Int, max: Int) -> Int {
        if (self > max) {
            return max
        } else if (self < min) {
            return min
        }
        return self
    }
}

extension String {
    var isLong: Bool {
        return count > 25
    }
}

extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
}

extension String {
    func isUppercased() -> Bool {
        return self == self.uppercased()
    }
}

//Protocol extensions

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

//Both Array and Set will now have that method, so we can try it out:
pythons.summarize()
beatles.summarize()

protocol Politician {
    var isDirty: Bool { get set }
    func takeBribe()
}
extension Politician {
    func takeBribe() {
        if isDirty {
            print("Thank you very much!")
        } else {
            print("Someone call the police!")
        }
    }
}

protocol Anime {
    var availableLanguages: [String] { get set }
    func watch(in language: String)
}
extension Anime {
    func watch(in language: String) {
        if availableLanguages.contains(language) {
            print("Now playing in \(language)")
        } else {
            print("Unrecognized language.")
        }
    }
}

protocol Club {
    func organizeMeeting(day: String)
}
extension Club {
//    override funcion must not be used here
    func organizeMeeting(day: String) {
//  override func organizeMeeting(day: String) {
        print("We're going to meet on \(day).")
    }
}

protocol Hamster {
    var name: String { get set }
    func runInWheel(minutes: Int)
}
extension Hamster {
    func runInWheel(minutes: Int) {
        print("\(name) is going for a run.")
        for _ in 0..<minutes {
            print("Whirr whirr whirr")
        }
    }
}


//Protocol-oriented programming
//Protocol extensions can provide default implementations for our own protocol methods. This makes it easy for types to conform to a protocol, and allows a technique called “protocol-oriented programming” – crafting your code around protocols and protocol extensions.

protocol IdentifiableOriented {
    var id: String { get set }
    func identify()
}


//We could make every conforming type write their own identify() method, but protocol extensions allow us to provide a default:
extension IdentifiableOriented {
    func identify() {
        print("My ID is \(id).")
    }
}

//Now when we create a type that conforms to Identifiable it gets identify() automatically:

struct UserOriented: IdentifiableOriented {
    var id: String
}

let twostraws = UserOriented(id: "twostraws")
twostraws.identify()


//1. Protocols describe what methods and properties a conforming type must have, but don’t provide the implementations of those methods.
//2. You can build protocols on top of other protocols, similar to classes.
//3. Extensions let you add methods and computed properties to specific types such as Int.
//4. Protocol extensions let you add methods and computed properties to protocols.
//5. Protocol-oriented programming is the practice of designing your app architecture as a series of protocols, then using protocol extensions to provide default method implementations.

protocol HasAge {
    var age: Int { get set }
    mutating func celebrateBirthday()
}

protocol Paintable { }
protocol Tileable { }
struct Wall: Paintable, Tileable { }


protocol Ridable { }
protocol Trainable { }
protocol Dog: Trainable { }


protocol CanFly {
    var maximumFlightSpeed: Int { get set }
}
protocol CanDrive {
    var maximumDrivingSpeed: Int { get set }
}

struct FlyingCar: CanFly, CanDrive {
    
    var maximumFlightSpeed: Int
    
    var maximumDrivingSpeed: Int
}


protocol Inflatable {
    mutating func refillAir()
}
extension Inflatable {
    mutating func refillAir() {
        print("Refilling the air.")
    }
}

protocol SuitableForKids {
    var minimumAge: Int { get set }
    var maximumAge: Int { get set }
}
protocol SupportsMultiplePlayers {
    var minimumPlayers: Int { get set }
    var maximumPlayers: Int { get set }
}
struct FamilyBoardGame: SuitableForKids, SupportsMultiplePlayers {
    var minimumAge = 3
    var maximumAge = 110
    var minimumPlayers = 1
    var maximumPlayers = 4
}
