import UIKit

//Structs, part two

//Initializers

//struct User {
//    var username: String
//}
//
//
//var user = User(username: "twostraws")

struct User {
    var username: String
//    No need to add func
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "twostraws"


struct Book {
    var title: String
    var author: String
    init(bookTitle: String, authorName: String ) {
        title = bookTitle
        author = authorName
    }
}

let book = Book(bookTitle: "Something", authorName: "Someone")
print(book)

struct Dictionary {
    var words = Set<String>()
}
let dictionary = Dictionary()

print(dictionary)


struct Country {
    var name: String
    var usesImperialMeasurements: Bool
    init(countryName: String) {
        name = countryName
        let imperialCountries = ["Liberia", "Myanmar", "USA"]
        if imperialCountries.contains(name) {
            usesImperialMeasurements = true
        } else {
            usesImperialMeasurements = false
        }
    }
}

struct Tree {
    var type: String
    var hasFruit: Bool
    init() {
        type = "Cherry"
        hasFruit = true
    }
}
let cherryTree = Tree()


print(cherryTree.hasFruit)

struct Cabinet {
    var height: Double
    var width: Double
    var area: Double
    init (itemHeight: Double, itemWidth: Double) {
        height = itemHeight
        width = itemWidth
        area = height * width
    }
}
let drawers = Cabinet(itemHeight: 1.4, itemWidth: 1.0)

//Referring to the current instance

//This self value is particularly useful when you create initializers that have the same parameter names as your property.

//self helps you distinguish between the property and the parameter
// self.name refers to the property, whereas name refers to the parameter.

struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

let name = Person(name: "Bosco")
print(name.name)


struct Conference {
    var name: String
    var location: String
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
let wwdc = Conference(name: "WWDC", location: "San Jose")

struct Cat {
    var name: String
    var breed: String
    var meowVolume: Int
    init(name: String, breed: String, meowVolume: Int) {
        self.name = name
        self.breed = breed
        self.meowVolume = meowVolume
    }
}
let toby = Cat(name: "Toby", breed: "Burmese", meowVolume: 2)


struct Character {
    var name: String
    var actor: String
    var probablyGoingToDie: Bool
    init(name: String, actor: String) {
        self.name = name
        self.actor = actor
        if self.actor == "Sean Bean" {
            probablyGoingToDie = true
        } else {
            probablyGoingToDie = false
        }
    }
}

let actor = Character(name: "John", actor: "Michell Page")

struct Parent {
    var numberOfKids: Int
    var tirednessPercent: Int
    init (kids: Int, percent: Int) {
        self.numberOfKids = kids
//         Initializers cannot finish until all properties have a value, and in this case tirednessPercent has not been set.
//        have a value
//        have a value
//        an actual VALUE !
        self.tirednessPercent = percent
    }
}
let james = Parent(kids: 2, percent: 2)


//Lazy properties

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct PersonFamilyTree {
    var name: String
//    Lazy properties are created only when first accessed.
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = PersonFamilyTree(name: "Ed")
//So, if you want to see the “Creating family tree!” message, you need to access the property at least once:
//Lazy properties are created only when first accessed.
ed.familyTree

//Static properties and methods

struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let edmund = Student(name: "Ed")
let taylor = Student(name: "Taylor")

print(taylor.name)

//Because the classSize struct belongs to the struct itself rather than instances of the struct, we need to read it using Student.classSize:
print(Student.classSize)


struct NewsStory {
    static var breakingNewsCount = 0
    static var regularNewsCount = 0
    var headline: String
    init(headline: String, isBreaking: Bool) {
        self.headline = headline
        if isBreaking {
            NewsStory.breakingNewsCount += 1
        } else {
            NewsStory.regularNewsCount += 1
        }
    }
}

//struct Person {
//    static var population = 0
//    var name: String
//    init(personName: String) {
//        name = personName
//Referencing a static property inside a regular method isn't allowed; this should use Person.population.
//        population += 1
//    }
//}

struct Pokemon {
    static var numberCaught = 0
    var name: String
    static func catchPokemon() {
        print("Caught!")
        Pokemon.numberCaught += 1
    }
}

let baby = Pokemon(name: "Baby")
let catchHim = Pokemon.catchPokemon()
print(Pokemon.numberCaught)


struct Raffle {
    var ticketsUsed = 0
    var name: String
    var tickets: Int
    init(name: String, tickets: Int) {
        self.name = name
        self.tickets = tickets
//        ticketsUsed is not declared as a static property.
//        Raffle.ticketsUsed += tickets
    }
}

struct LegoBrick {
    static var numberMade = 0
    var shape: String
    var color: String
    init(shape: String, color: String) {
        self.shape = shape
        self.color = color
        LegoBrick.numberMade += 1
    }
}

//Access control

struct PersonAccess {
    var id: String

    init(id: String) {
        self.id = id
    }
}

let edAccess = PersonAccess(id: "12345")
print(edAccess.id)

//with private

struct PersonPrivate {
    private var id: String

    init(id: String) {
        self.id = id
    }
}

//Now only methods inside Person can read the id property. For example:

let edPersonPrivate = PersonPrivate(id: "098765432")
// if you uncomment you will see id is inaccessible
//print(edPersonPrivate.id)


struct PersonPrivateWithFunction {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let edPersonPrivateWithFuncion = PersonPrivateWithFunction(id: "456789987654")
edPersonPrivateWithFuncion.identify()
//we can acces the information inside de struct only because id is accessible within the Struct PersonPrivateWithFunction

//struct FacebookUser {
//    private var privatePosts: [String]
//    public var publicPosts: [String]
//}
//let user = FacebookUser()


//struct Doctor {
//    var name: String
//    var location: String
//    private var currentPatient = "No one"
//}
//let drJones = Doctor(name: "Esther Jones", location: "Bristol")
// This has a private property, so Swift is unable to generate its memberwise initializer for us.


struct Office {
    private var passCode: String
    var address: String
    var employees: [String]
    init(address: String, employees: [String]) {
        self.address = address
        self.employees = employees
        self.passCode = "SEKRIT"
    }
}
let monmouthStreet = Office(address: "30 Monmouth St", employees: ["Paul Hudson"])

print(monmouthStreet.address)

struct School {
    var staffNames: [String]
    private var studentNames: [String]
    init(staff: String...) {
        self.staffNames = staff
//        we init the private var studentNames because: Initializers cannot finish until all properties have a value, and in this case tirednessPercent has not been set.
        self.studentNames = [String]()
    }
}
let royalHigh = School(staff: "Mrs Hughes")


struct Customer {
    var name: String
    private var creditCardNumber: Int
    init(name: String, creditCard: Int) {
        self.name = name
        self.creditCardNumber = creditCard
    }
}
let lottie = Customer(name: "Lottie Knights", creditCard: 1234567890)

//1. You can create your own types using structures, which can have their own properties and methods.
//2. You can use stored properties or use computed properties to calculate values on the fly.
//3. If you want to change a property inside a method, you must mark it as mutating.
//4. Initializers are special methods that create structs. You get a memberwise initializer by default, but if you create your own you must give all properties a value.
//5. Use the self constant to refer to the current instance of a struct inside a method.
//6. The lazy keyword tells Swift to create properties only when they are first used.
//7. You can share properties and methods across all instances of a struct using the static keyword.
//8. Access control lets you restrict what code can use properties and methods.

//Computed properties let us run code to return a value.
//You can share properties and methods across all instances of a struct using static

