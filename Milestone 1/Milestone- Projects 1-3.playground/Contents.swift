import UIKit

//Key points

//If you remember, there are five key differences between structs and classes:
//
//1. Classes don’t come with a memberwise initializer; structs get these by default.
//2. Classes can use inheritance to build up functionality; structs cannot.
//3. If you copy a class, both copies point to the same data; copies of structs are always unique.
//4. Classes can have deinitializers; structs cannot.
//5. You can change variable properties inside constant classes; properties inside constant structs are fixed regardless of whether the properties are constants or variables.


// TIP
// TIP
// TIP


//Tip: One of the fascinating details of SwiftUI is how it completely inverts how we use structs and classes. In UIKit we would use structs for data and classes for UI, but in SwiftUI it’s completely the opposite – a good reminder of the importance of learning things, even if you think they aren’t immediately useful.

// TIP
// TIP
// TIP


// Working with ForEach

//The second thing I’d like to discuss is ForEach, which we have used with code like this:

ForEach(0 ..< 100) { number in
    Text("Row \(number)")
}

let agents = ["Cyril", "Lana", "Pam", "Sterling"]

VStack {
    ForEach(0 ..< agents.count) {
        Text(self.agents[$0])
    }
}

//In our array of strings that’s no longer possible, but we can clearly see that each value is unique: the values in ["Cyril", "Lana", "Pam", "Sterling"] don’t repeat. So, what we can do is tell SwiftUI that the strings themselves – “Cyril”, “Lana”, etc – are what can be used to identify each view in the loop uniquely.

//In code, we’d write this:

VStack {
    ForEach(agents, id: \.self) {
        Text($0)
    }
}

//So rather than loop over integers and use that to read into the array, we’re now reading items in the array directly – just like a for loop would do.


//Working with bindings

//First let’s look at the simplest form of custom binding, which just stores the value away in another @State property and reads that back:


struct ContentView: View {
    @State var selection = 0

    var body: some View {
        let binding = Binding(
            get: { self.selection },
            set: { self.selection = $0 }
        )

        return VStack {
            Picker("Select a number", selection: binding) {
                ForEach(0 ..< 3) {
                    Text("Item \($0)")
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}


//
//So, that binding is effectively just acting as a passthrough – it doesn’t store or calculate any data itself, but just acts as a shim between our UI and the underlying state value that is being manipulated.
//
//However, notice that the picker is now made using selection: binding – no dollar sign required. We don’t need to explicit ask for the two-way binding here because it already is one.
//
//If we wanted to, we could create a more advanced binding that does more than just pass through a single value. For example, imagine we had a form with three toggle switches: does the user agreed to the terms and conditions, agree to the privacy policy, and agree to get emails about shipping.
//
//We might represent that as three Boolean @State properties:


@State var agreedToTerms = false
@State var agreedToPrivacyPolicy = false
@State var agreedToEmails = false


//Although the user could just toggle them all by hand, we could use a custom binding to do them all at once. This binding would be true if all three of those Booleans were true, but if it got changed then it would update them all, like this:

let agreedToAll = Binding(
    get: {
        self.agreedToTerms && self.agreedToPrivacyPolicy && self.agreedToEmails
    },
    set: {
        self.agreedToTerms = $0
        self.agreedToPrivacyPolicy = $0
        self.agreedToEmails = $0
    }
)

//So now we can create four toggle switches: one each for the individual Booleans, and one control switch that agrees or disagrees to all three at once:

struct ContentView: View {
    @State var agreedToTerms = false
    @State var agreedToPrivacyPolicy = false
    @State var agreedToEmails = false

    var body: some View {
        let agreedToAll = Binding<Bool>(
            get: {
                self.agreedToTerms && self.agreedToPrivacyPolicy && self.agreedToEmails
            },
            set: {
                self.agreedToTerms = $0
                self.agreedToPrivacyPolicy = $0
                self.agreedToEmails = $0
            }
        )

        return VStack {
            Toggle(isOn: $agreedToTerms) {
                Text("Agree to terms")
            }

            Toggle(isOn: $agreedToPrivacyPolicy) {
                Text("Agree to privacy policy")
            }

            Toggle(isOn: $agreedToEmails) {
                Text("Agree to receive shipping emails")
            }

            Toggle(isOn: agreedToAll) {
                Text("Agree to all")
            }
        }
    }
}

//Again, custom bindings aren’t something you’ll want that often, but it’s so important to take the time to look behind the curtain and understand what’s going on. Even though it’s incredibly smart, SwiftUI is just a tool, not magic!

