//
//  Astronaut.swift
//  Moonshot
//
//  Created by J B on 04/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import Foundation


struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

//As you can see, I’ve made that conform to Codable so we can create instances of this struct straight from JSON, but also Identifiable so we can use arrays of astronauts inside ForEach and more – that id field will do just fine.


