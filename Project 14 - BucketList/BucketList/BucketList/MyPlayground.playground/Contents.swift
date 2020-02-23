import UIKit

var str = "Hello, playground"


// Swift is smart enough to know thanks to the Swift developer and the LLVM, larger compiler project that sits behind Swift that a shorten list of numbers have a order. They have already done all the hard work of checking whether that calculation is actually true, so we don’t have to worry about it.
struct ContentView: View {
    let values = [1, 5, 3, 6, 2, 9].sorted()

    var body: some View {
        List(values, id: \.self) {
            Text(String($0))
        }
    }
}


// But when it comes to more complex things like listing names... we have to use the operator overloading. This allows us to apply shorted to any part of our code without the need to make changes everytime we want one logic. We can now use .sorted() at the end of our code so that the compiler knows we want that code to be shorted in the logic specified in the User struct.


struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

//There’s not a lot of code in there, but there is still a lot to unpack.

//First, yes the method is just called <, which is the “less than” operator. It’s the job of the method to decide whether one user is “less than” (in a sorting sense) another, so we’re adding functionality to an existing operator. This is called operator overloading, and it can be both a blessing and a curse.

//Second, lhs and rhs are coding conventions short for “left-hand side” and “right-hand side”, and they are used because the < operator has one operand on its left and one on its right.

//Third, this method must return a Boolean, which means we must decide whether one object should be sorted before another. There is no room for “they are the same” here – that’s handled by another protocol called Equatable.

//Fourth, the method must be marked as static, which means it’s called on the User struct directly rather than a single instance of the struct.

//Finally, our logic here is pretty simple: we’re just passing on the comparison to one of our properties, asking Swift to use < for the two last name strings. You can add as much logic as you want, comparing as many properties as needed, but ultimately you need to return true or false.

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Juan", lastName: "Ybarra"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

//Tip: One thing you can’t see in that code is that conforming to Comparable also gives us access to the > operator – greater than. This is the opposite of <, so Swift creates it for us by using < and flipping the Boolean between true and false.



//Writing data to the documents directory

struct ContentView: View {
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    var body: some View {
        Text("Hello World")
        .onTapGesture {
            let str = "Test Message"
            let url = self.getDocumentsDirectory().appendingPathComponent("message.txt")

            do {
                try str.write(to: url, atomically: true, encoding: .utf8)
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}


//Switching view states with enums


