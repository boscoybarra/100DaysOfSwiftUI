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

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView: View {
    
    enum LoadingState {
        case loading, success, failed
    }
    
//    Those views could be nested if you want, but they don’t have to be – it really depends on whether you plan to use them elsewhere and the size of your app.

//    With those two parts in place, we now effectively use ContentView as a simple wrapper that tracks the current app state and shows the relevant child view. That means giving it a property to store the current LoadingState value:
    
    var loadingState = LoadingState.loading
    
    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}


//Communicating with a MapKit coordinator

struct ContentView: View {

    var body: some View {
        MapView()
        .edgesIgnoringSafeArea(.all)
    }
}


// On another file calles MapView.swift :

import MapKit
import SwiftUI

//That creates a new typealias – a type name – called “Context”, and wherever Swift sees Context in code it will consider it the same as UIViewRepresentableContext<Self>, where Self is whatever type we’re working with. In practical terms, this means we can just write Context rather than UIViewRepresentableContext<MapView>, and they mean exactly the same thing.

struct MapView: UIViewRepresentable {
//  Just like working with UIImagePickerController, this means creating a nested class that inherits from NSObject, making it conform to whatever delegate protocol our view or view controller works with, and giving it a reference to the parent struct so it can pass data back up to SwiftUI.
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
//  Just as with the UIViewControllerRepresentable protocol, that means adding a method called makeCoordinator() that sends back a configured instance of our Coordinator. This should be added to the MapView struct, and it will send itself to the coordinator so it can report back what’s happening.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
//  Remember, our coordinator is the delegate of the map view, which means when something interesting happens it gets notified – when the map moves, when it starts and finishes loading, when the user was located on the map, when a map pin was touched, and so on.
        mapView.delegate = context.coordinator
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of England"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        mapView.addAnnotation(annotation)

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
    }
}

// Using Touch ID and Face ID with SwiftUI

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if self.isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        // authenticated successfully
                        self.isUnlocked = true
                    } else {
                        // there was a problem
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}
