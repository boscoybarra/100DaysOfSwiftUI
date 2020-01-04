//
//  Mission.swift
//  Moonshot
//
//  Created by J B on 04/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import Foundation


//Before we look at how to load JSON into that, I want to demonstrate one more thing: our CrewRole struct was made specifically to hold data about missions, and as a result we can actually put the CrewRole struct inside the Mission struct like this:

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
