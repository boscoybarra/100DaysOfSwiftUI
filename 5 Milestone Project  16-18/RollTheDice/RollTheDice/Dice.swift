//
//  Dice.swift
//  RollTheDice
//
//  Created by J B on 03/04/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

class Dice: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
}


class Dices: ObservableObject {
    static let saveKey = "SavedData"
//     if we add or remove items from that array a change notification will be sent out. However, if we quietly change an item inside the array then SwiftUI won’t detect that change, and no views will be refreshed.
    
//    Even better, we can use access control to stop external writes to the people array, meaning that our views must use the add() method to add prospects. This is done by changing the definition of the people property to this:
    @Published private(set) var people: [Dice]

    init() {
        
        // Use JSON and the documents directory for saving and loading our user data. See Extension on FileManager
        self.people = FileManager.default.readDocument(from: Self.saveKey) ?? []

        
//       Using userDefaults option:
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                self.people = decoded
//                return
//            }
//        }
//
//        self.people = []
    }
    
//    To fix this, we need to tell SwiftUI by hand that something important has changed. So, rather than flipping a Boolean in ProspectsView, we are instead going to call a method on the Prospects class to flip that same Boolean while also sending a change notification out.
    func toggle(_ prospect: Dice) {
        //        Important: You should call objectWillChange.send() before changing your property, to ensure SwiftUI gets its animations correct.
        objectWillChange.send()
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func add(_ prospect: Dice) {
        people.append(prospect)
        save()
    }
}
