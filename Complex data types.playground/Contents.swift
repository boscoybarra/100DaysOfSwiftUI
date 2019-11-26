import UIKit

//To create a set you must pass in an array of items rather than just loose integers

// Sets

Set([1, 1, 2, 2])


//Tuples

//You can’t add or remove items from a tuple; they are fixed in size.
//You can’t change the type of items in a tuple; they always have the same types they were created with.
//You can access items in a tuple using numerical positions or by naming them, but Swift won’t let you read numbers or names that don’t exist.

var name = (first: "Taylor", last: "Swift")

//Tuple
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

//Set
let set = Set(["aardvark", "astronaut", "azalea"])

//Arrays
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]


//Dictionaries
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

//Note
//Note: When using type annotations, dictionaries are written in brackets with a colon between your identifier and value types. For example, [String: Double] and [String: String].


//Dictionary default values
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
//We can fix this by giving the dictionary a default value of “Unknown”, so that when no ice cream is found for Charlotte we get back “Unknown” rather than nil:
favoriteIceCream["Charlotte", default: "Unknown"]


//MARK:
//Creating empty collections
var teams = [String: String]()

//We can then add entries later on, like this:
teams["Paul"] = "Red"

//Similarly, you can create an empty array to store integers like this:
var results = [Int]()

//The exception is creating an empty set, which is done differently:
var words = Set<String>()
var numbers = Set<Int>()

//This is because Swift has special syntax only for dictionaries and arrays; other types must use angle bracket syntax like sets.
//
//If you wanted, you could create arrays and dictionaries with similar syntax:
var scores = Dictionary<String, Int>()
var resultsDic = Array<Int>()



//MARK:
//Enumerations: perfect for identifying fixed data to avoid duplications or different ways to same the same thing

enum Result {
    case success
    case failure
}

let result4 = Result.failure

//KEY: This stops you from accidentally using different strings each time.

//Enum associated values
//enum Activity {
//    case bored
//    case running
//    case talking
//    case singing
//}

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

//Now we can be more precise – we can say that someone is talking about football:
let talking = Activity.talking(topic: "football")

//Enum raw values
//enum Planet: Int {
//    case mercury
//    case venus
//    case earth
//    case mars
//}
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 2)

//Now Swift will assign 1 to mercury and count upwards from there, meaning that earth is now the third planet.

//You’ve made it to the end of the second part of this series, so let’s summarize:

//1. Arrays, sets, tuples, and dictionaries let you store a group of items under a single value. They each do this in different ways, so which you use depends on the behavior you want.
//2. Arrays store items in the order you add them, and you access them using numerical positions.
//3. Sets store items without any order, so you can’t access them using numerical positions.
//4. Tuples are fixed in size, and you can attach names to each of their items. You can read items using numerical positions or using your names.
//5. Dictionaries store items according to a key, and you can read items using those keys.
//6. Enums are a way of grouping related values so you can use them without spelling mistakes.
//7. You can attach raw values to enums so they can be created from integers or strings, or you can add associated values to store additional information about each case.
