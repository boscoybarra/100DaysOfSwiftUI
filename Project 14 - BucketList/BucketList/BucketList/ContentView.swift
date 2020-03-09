//
//  ContentView.swift
//  BucketList
//
//  Created by Bosco on 23/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
//    First we need some new state in ContentView that tracks whether the app is unlocked or not. So, start by adding this new property:
    @State private var isUnlocked = false

    var body: some View {
        ZStack {
                if isUnlocked {
                MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                    .edgesIgnoringSafeArea(.all)
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            let newLocation = CodableMKPointAnnotation()
    //                       We hardcore the title
                            newLocation.title = "Example location"
                            newLocation.coordinate = self.centerCoordinate
                            self.locations.append(newLocation)
                            
                            self.selectedPlace = newLocation
                            self.showingEditScreen = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                }
                } else {
//                 button here
                    Button("Unlock Places") {
                        self.authenticate()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                // edit this place
                self.showingEditScreen = true
            })
        }
//      And finally, we need to bind showingEditScreen to a sheet, so our EditView struct gets presented with a place mark at the right time. Remember, we can’t use if let here to unwrap the selectedPlace optional, so we’ll do a simple check then force unwrap – it’s just as safe.
//        .sheet(isPresented: $showingEditScreen) {
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")

        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
//    Using this approach we can write any amount of data in any number of files – it’s much more flexible than UserDefaults, and if we need it also allows us to load and save data as needed rather than immediately when the app launches as with UserDefaults.

//    However, another benefit of this approach is the way we write stuff. Sure, we’re going to use the same getDocumentsDirectory() and JSONEncoder dance to get our data ready, but this time we’re going to use the write(to:) method to save the data to disk, writing to a particular URL.

//    Previously I showed you this method with strings, but the Data version is even better because it lets us do something quite amazing in just one line of code: we can ask iOS to ensure the file is written with encryption so that it can only be read once the user has unlocked their device. This is in addition to requesting atomic writes – iOS does almost all the work for us.

//    Add this method to ContentView now:
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
//    Yes, all it takes to ensure that the file is stored with strong encryption is to add .completeFileProtection to the data writing options.
    
    
//    So, we’re going to write a dedicated authenticate() method that handles all the biometric work:

//1 Creating an LAContext so we have something that can check and perform biometric authentication.
//2 Ask it whether the current device is capable of biometric authentication.
//3 If it is, start the request and provide a closure to run when it completes.
//4 When the request finishes, push our work back to the main thread and check the result.
//5 If it was successful, we’ll set isUnlocked to true so we can run our app as normal.
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
