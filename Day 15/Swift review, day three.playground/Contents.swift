import UIKit

//Properties

struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }

        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts")
taylor.clothes = "short skirts"

//Computed properties

//struct Person {
//    var age: Int
//
//    var ageInDogYears: Int {
//        get {
//            return age * 7
//        }
//    }
//}

// We can simplify the computed properties like so:
struct PersonComputed {
    var age: Int
    var ageInDogYears: Int {
        return age * 7
    }
}

var fan = PersonComputed(age: 25)
print(fan.ageInDogYears)


//Static properties and methods
struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"

    var name: String
    var age: Int
}

let fanStatic = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)

//Because static methods belong to the struct itself rather than to instances of that struct, you can't use it to access any non-static properties from the struct.

//Access control
class TaylorFan {
    private var name: String?
}

//Public: this means everyone can read and write the property.
//Internal: this means only your Swift code can read and write the property. If you ship your code as a framework for others to use, they won’t be able to read the property.
//File Private: this means that only Swift code in the same file as the type can read and write the property.
//Private: this is the most restrictive option, and means the property is available only inside methods that belong to the type, or its extensions.

//Polymorphism and typecasting
class Album {
    var name: String

    init(name: String) {
        self.name = name
    }

    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}

//Converting types with typecasting

for album in allAlbums {
    print(album.getPerformance())

    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

//Swift also allows optional downcasting at the array level, although it's a bit more tricksy because you need to use the nil coalescing operator to ensure there's always a value for the loop. Here's an example:

for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.location)
}

//What that means is, “try to convert allAlbums to be an array of LiveAlbum objects, but if that fails just create an empty array of live albums and use that instead” – i.e., do nothing.


//Closures

//A closure can be thought of as a variable that holds code.

//Trailing closures
//As closures are used so frequently, Swift can apply a little syntactic sugar to make your code easier to read. The rule is this: if the last parameter to a method takes a closure, you can eliminate that parameter and instead provide it as a block of code inside braces. For example, we could convert the previous code to this:

let vw = UIView()

UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}

//It does make your code shorter and easier to read, so this syntax form – known as trailing closure syntax – is preferred.

