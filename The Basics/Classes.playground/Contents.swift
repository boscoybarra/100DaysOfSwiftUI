import UIKit

//Classes

//they introduce a new, important, and complex feature called inheritance – the ability to make one class build on the foundations of another.

//Martin Fowler wrote, “any fool can write code that a computer can understand, but good programmers write code that humans can understand.”

//when you pass data between your layouts, you’ll usually be using classes.

//Creating your own classes

//The first difference between classes and structs is that classes never come with a memberwise initializer. This means if you have properties in your class, you must always create your own initializer.

class TIE {
    var name: String
    var speed: Int
    init(name: String, speed: Int) {
        self.name = name
        self.speed = speed
    }
}
let fighter = TIE(name: "TIE Fighter", speed: 50)
let interceptor = TIE(name: "TIE Interceptor", speed: 70)

class VideoGame {
    var hero: String
    var enemy: String
    init(heroName: String, enemyName: String) {
        self.hero = heroName
        self.enemy = enemyName
    }
}
let monkeyIsland = VideoGame(heroName: "Guybrush Threepwood", enemyName: "LeChuck")

class ThemePark {
    var entryPrice: Int
    var rides: [String]
    init(rides: [String]) {
        self.rides = rides
        self.entryPrice = rides.count * 2
    }
}

class Empty { }
let nothing = Empty()


//Class inheritance

//The second difference between classes and structs is that you can create a class based on an existing class – it inherits all the properties and methods of the original class, and can add its own on top.

// class inheritance or subclassing, the class you inherit from is called the “parent” or “super” class, and the new class is called the “child” class.

class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

class Handbag {
    var price: Int
    init(price: Int) {
        self.price = price
    }
}
class DesignerHandbag: Handbag {
    var brand: String
    init(brand: String, price: Int) {
        self.brand = brand
        super.init(price: price)
    }
}

class Bicycle {
    var color: String
    init(color: String) {
        self.color = color
    }
}
class MountainBike: Bicycle {
    var tireThickness: Double
    init(color: String, tireThickness: Double) {
        self.tireThickness = tireThickness
        super.init(color: color)
    }
}

class Printer {
    var cost: Int
    init(cost: Int) {
        self.cost = cost
    }
}
class LaserPrinter: Printer {
    var model: String
    init(model: String, cost: Int) {
        self.model = model
        super.init(cost: cost)
    }
}


class Food {
    var name: String
    var nutritionRating: Int
    init(name: String, nutritionRating: Int) {
        self.name = name
        self.nutritionRating = nutritionRating
    }
}
class Pizza: Food {
    init() {
        super.init(name: "Pizza", nutritionRating: 3)
    }
}

class Shape {
    var sides: Int
    init(sides: Int) {
        self.sides = sides
    }
}
class Rectangle: Shape {
    var color: String
    init(color: String) {
        self.color = color
        super.init(sides: 4)
    }
}


//Overriding methods

class Dogi {
    func makeNoise() {
        print("Woof!")
    }
}


class Poodlei: Dogi {
    override func makeNoise() {
        print("Yip!")
    }
}

let poppy = Poodlei()
poppy.makeNoise()


class Band {
    func singSong() {
        print("Here's a new song.")
    }
}
class MetalBand: Band {
    override func singSong() {
        print("Ruuuuh ruh ruh ruuuuuh!")
    }
}
let lordi = MetalBand()
lordi.singSong()

//class Airplane: Jet {
//    func takeOff() {
//        print("Fasten your seatbelts.")
//    }
//}
//class Jet: Airplane {
//    override func takeOff() {
//        print("Someone call Kenny Loggins, because we're going into the danger zone!")
//    }
//}
//let f14 = Jet()
//f14.takeOff()

//This attempts to make one class inherit from another, and the other class inherit from the first, which is not valid Swift.


class Cinema {
    func showMovie() {
        print("Get your popcorn ready!")
    }
}
class IMAXCinema: Cinema {
    override func showMovie() {
        print("Get your eardrums ready!")
    }
}
let londonIMAX = IMAXCinema()
londonIMAX.showMovie()

class Store {
    func restock() -> String {
        return "Fill up the empty shelves"
    }
}
class GroceryStore: Store {
    override func restock() -> String {
        return "We need to buy more food."
    }
}
let tesco = GroceryStore()
tesco.restock()


//Final classes

final class DogiFinal {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

//final class Landmark { }
//final class Monument: Landmark { }
//This attempts to inherit from a final class, which is not allowed.

//Copying objects

//The third difference between classes and structs is how they are copied.

//When you copy a struct, both the original and the copy are different things – changing one won’t change the other. When you copy a class, both the original and the copy point to the same thing, so changing one does change the other.

//class Singer {
//    var name = "Taylor Swift"
//}

struct Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name)

//

class GalacticaCrew {
    var isCylon = false
}

var starbuck = GalacticaCrew()
var tyrol = starbuck
tyrol.isCylon = true
print(starbuck.isCylon)
print(tyrol.isCylon)
// When you copy a struct, the original and the copy are different things with their own properties.

class Statue {
    var sculptor = "Unknown"
}
var venusDeMilo = Statue()
venusDeMilo.sculptor = "Alexandros of Antioch"
var david = Statue()
david.sculptor = "Michaelangelo"
print(venusDeMilo.sculptor)
print(david.sculptor)
//This creates TWO different statues with Statue(), so it prints two different sculptors.


class Starship {
    var maxWarp = 9.0
}
var voyager = Starship()
voyager.maxWarp = 9.975
var enterprise = voyager
enterprise.maxWarp = 9.6
print(voyager.maxWarp)
print(enterprise.maxWarp)


struct Calculator {
    var currentTotal = 0
}
var baseModel = Calculator()
var casio = baseModel
var texas = baseModel
casio.currentTotal = 556
texas.currentTotal = 384
print(casio.currentTotal)
print(texas.currentTotal)

//When you copy a struct, the original and the copy are different things with their own properties.

class Hater {
    var isHating = true
}
var hater1 = Hater()
var hater2 = hater1
hater1.isHating = false
print(hater1.isHating)
print(hater2.isHating)


class Ewok {
    var fluffinessPercentage = 100
}
var chirpa = Ewok()
var wicket = Ewok()
chirpa.fluffinessPercentage = 90
print(wicket.fluffinessPercentage)
print(chirpa.fluffinessPercentage)

class Queen {
    var isMotherOfDragons = false
}
var elizabeth = Queen()
var daenerys = Queen()
daenerys.isMotherOfDragons = true
print(elizabeth.isMotherOfDragons)
print(daenerys.isMotherOfDragons)


class BasketballPlayer {
    var height = 200.0
}
var lebron = BasketballPlayer()
lebron.height = 203.0
var curry = BasketballPlayer()
curry.height = 190
print(lebron.height)
print(curry.height)

class Hairdresser {
    var clients = [String]()
}
var tim = Hairdresser()
tim.clients.append("Jess")
var dave = tim
dave.clients.append("Sam")
print(tim.clients.count)
print(dave.clients.count)

//Deinitializers

//The fourth difference between classes and structs is that classes can have deinitializers – code that gets run when an instance of a class is destroyed.

class Persona {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Persona()
    person.printGreeting()
}


//Mutability

//The final difference between classes and structs is the way they deal with constants. If you have a constant struct with a variable property, that property can’t be changed because the struct itself is constant.

class SingerMutability {
    var name = "Taylor Swift"
}

let taylor = SingerMutability()
taylor.name = "Ed Sheeran"
print(taylor.name)

//If you want to stop that from happening you need to make the property constant:
//
//class Singer {
//    let name = "Taylor Swift"
//}

class PizzaMute {
    private var toppings = [String]()
    func add(topping: String) {
        toppings.append(topping)
    }
}
var pizza = PizzaMute()
pizza.add(topping: "Mushrooms")

// NOTE: How structs and classes in this two examples work. The plantFlowers() method attempts to modify the numberOfFlowers property, but it isn't marked as mutating.


struct ParkStruct {
    var numberOfFlowers = 1000
    mutating func plantFlowers() {
        numberOfFlowers += 50
    }
}
var park = ParkStruct()
park.plantFlowers()
park.plantFlowers()


class ParkClass {
    var numberOfFlowers = 1000
    func plantFlowers() {
        numberOfFlowers += 50
    }
}

let parkClass = ParkClass()
parkClass.plantFlowers()
parkClass.plantFlowers()


struct Piano {
    var untunedKeys = 3
    mutating func tune() {
        if untunedKeys > 0 {
            untunedKeys -= 1
        }
    }
}
var piano = Piano()
piano.tune()

class Light {
    var onState = false
    func toggle() {
        if onState {
            onState = false
        } else {
            onState = true
        }
        print("Click")
    }
}
let light = Light()
light.toggle()

class Phasers {
    var energyLevel = 100
    func firePhasers() {
        if energyLevel > 10 {
            print("Firing!")
            energyLevel -= 10
        }
    }
}
var phasers = Phasers()
phasers.firePhasers()

struct Barbecue {
    var charcoalBricks = 20
    mutating func addBricks(_ number: Int) {
        charcoalBricks += number
    }
}
var barbecue = Barbecue()
barbecue.addBricks(4)

//1. Classes and structs are similar, in that they can both let you create your own types with properties and methods.
//2. One class can inherit from another, and it gains all the properties and methods of the parent class. It’s common to talk about class hierarchies – one class based on another, which itself is based on another.
//3. You can mark a class with the final keyword, which stops other classes from inheriting from it.
//4. Method overriding lets a child class replace a method in its parent class with a new implementation.
//5. When two variables point at the same class instance, they both point at the same piece of memory – changing one changes the other.
//6. Classes can have a deinitializer, which is code that gets run when an instance of the class is destroyed.
//7. Classes don’t enforce constants as strongly as structs – if a property is declared as a variable, it can be changed regardless of how the class instance was created.




