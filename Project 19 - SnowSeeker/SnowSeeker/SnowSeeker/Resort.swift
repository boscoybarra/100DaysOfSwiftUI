//
//  Resort.swift
//  SnowSeeker
//
//  Created by J B on 09/04/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI



//    We can also write the above lines like this:
//    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]

struct Resort: Codable, Identifiable {
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
}
