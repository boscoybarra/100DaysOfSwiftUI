//
//  Prospect.swift
//  HotProspects
//
//  Created by Bosco on 14/03/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
    
//    Note:
//    fileprivate, which means “this property can only be used by code inside the current file.” Of course, we still want to read that property, and so we can deploy another useful Swift feature: fileprivate(set), which means “this property can be read from anywhere, but only written from the current file”
}

//Yes, that’s a class rather than a struct. This is intentional, because it allows us to change instances of the class directly and have it be updated in all other views at the same time. Remember, SwiftUI takes care of propagating that change to our views automatically, so there’s no risk of views getting stale.

//When it comes to sharing that across multiple views, one of the best things about SwiftUI’s environment is that it uses the same ObservableObject protocol we’ve been using with the @ObservedObject property wrapper. This means we can mark properties that should be announced using the @Published property wrapper – SwiftUI takes care of most of the work for us.

//So, add this class in Prospect.swift:


class Prospects: ObservableObject {
    static let saveKey = "SavedData"
//     if we add or remove items from that array a change notification will be sent out. However, if we quietly change an item inside the array then SwiftUI won’t detect that change, and no views will be refreshed.
    
//    Even better, we can use access control to stop external writes to the people array, meaning that our views must use the add() method to add prospects. This is done by changing the definition of the people property to this:
    @Published private(set) var people: [Prospect]

    init() {
//       Adding userDefaults
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }

        self.people = []
    }
    
//    To fix this, we need to tell SwiftUI by hand that something important has changed. So, rather than flipping a Boolean in ProspectsView, we are instead going to call a method on the Prospects class to flip that same Boolean while also sending a change notification out.    
    func toggle(_ prospect: Prospect) {
        //        Important: You should call objectWillChange.send() before changing your property, to ensure SwiftUI gets its animations correct.
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
}
