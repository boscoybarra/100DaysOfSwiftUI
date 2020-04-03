import UIKit

var str = "Hello, playground"

// Functional programming

//let numbers = [1, 2, 3, 4, 5]
//var evens = [Int]()
//
//for number in numbers {
//    if number.isMultiple(of: 2) {
//        evens.append(number)
//    }
//}

let numbers = [1, 2, 3, 4, 5]
let evens = numbers.filter { $0.isMultiple(of: 2) }
print(evens)

// 1. It’s no longer possible to put a surprise break inside the loop – filter() will always process every element in the array, and this extra simplicity means we can focus on the test itself.
// 2. Rather than providing a closure we can call a shared function instead, which is great for code reuse.
// 3. The resulting evens array is now constant, so we can’t modify it by accident afterwards.

//Writing less code is always nice, but writing code that is simpler, more reusable, and less variable is even better!

let numbers = ["1", "2", "fish", "3"]
let evensMap = numbers.map(Int.init)
let evensCompactMap = numbers.compactMap(Int.init)
print(evensMap)
print(evensCompactMap)


enum NetworkError: Error {
    case badURL
}

func createResult() -> Result<String, NetworkError> {
    return .failure(.badURL)
}

let result = createResult()

do {
    let successString = try result.get()
    print(successString)
} catch {
    print("Oops! There was an error.")
}


let result = Result { try String(contentsOf: someURL) }
