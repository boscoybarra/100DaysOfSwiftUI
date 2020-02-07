import UIKit

var str = "Hello, playground"


//Here’s a quick recap of all the new things we covered in the last three projects:
//
//Building custom Codable conformance
//Sending and receiving data using URLSession
//The disabled() modifier for views
//Building custom UI components using @Bindable
//Using AnyView for type erasure
//Adding multiple buttons to an alert
//How Swift’s Hashable protocol is used in SwiftUI
//Using the @FetchRequest property wrapper to query Core Data
//Sorting Core Data results using NSSortDescriptor
//Creating custom NSManagedObject subclasses
//Filtering data using NSPredicate
//Creating relationships between Core Data entities


struct User: Codable {
    var firstName: String
    var lastName: String
}

//And here is some JSON data with the same two properties, but using snake case:

let str = """
{
    "first_name": "Andrew",
    "last_name": "Glouberman"
}
"""

let data = Data(str.utf8)

//If we try to decode that JSON into a User instance, it won’t work:



do {
    let decoder = JSONDecoder()

    let user = try decoder.decode(User.self, from: data)
    print("Hi, I'm \(user.firstName) \(user.lastName)")
} catch {
    print("Whoops: \(error.localizedDescription)")
}


//However, if we modify the key decoding strategy before we call decode(), we can ask Swift to convert snake case to and from camel case. So, this will succeed:

do {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    let user = try decoder.decode(User.self, from: data)
    print("Hi, I'm \(user.firstName) \(user.lastName)")
} catch {
    print("Whoops: \(error.localizedDescription)")
}

//That works great when we’re converting snake_case to and from camelCase, but what if our data is completely different?
//
//As an example, take a look at this JSON:

let str = """
{
    "first": "Andrew",
    "last": "Glouberman"
}
"""

//It still has the first and last name of a user, but the property names don’t match our struct at all.
//
//When we were looking at Codable I said that we can create an enum of coding keys that describe which keys should be encoded and decoded. At the time I said “this enum is conventionally called CodingKeys, with an S on the end, but you can call it something else if you want,” and while that’s true it’s not the whole story.
//
//You see, the reason we conventionally use CodingKeys for the name is that this name has super powers: if a CodingKeys enum exists, Swift will automatically use it to decide how to encode and decode an object for times we don’t provide custom Codable implementations.
//
//I realize that’s a lot to take in, so it’s best demonstrated with some code. Try changing the User struct to this:

struct User: Codable {
    enum ZZZCodingKeys: CodingKey {
        case firstName
    }

    var firstName: String
    var lastName: String
}


//That code will compile just fine, because the name ZZZCodingKeys is meaningless to Swift – it’s just a nested enum. But if you rename the enum to just CodingKeys you’ll find the code no longer builds: we’re now instructing Swift to encode and decode just the firstName property, which means there is no initializer that handles setting the lastName property - and that’s not allowed.
//
//All this matters because CodingKeys has a second super power: if we attach raw value strings to our properties, Swift will use those for the JSON property names. That is, the case names should match our Swift property names, and the case values should match the JSON property names.
//
//So, let’s return to our example JSON:


let str = """
{
    "first": "Andrew",
    "last": "Glouberman"
}
"""

//That uses “first” and “last” for property names, whereas our User struct uses firstName and lastName. This is a great place where CodingKeys can come to the rescue: we don’t need to write a custom Codable conformance, because we can just add coding keys that marry up our Swift property names to the JSON property names, like this:


struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }

    var firstName: String
    var lastName: String
}
