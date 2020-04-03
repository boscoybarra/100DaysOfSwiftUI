//
//  User.swift
//  Milestone Projects 10-12
//
//  Created by J B on 05/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import Foundation


struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
    
}
