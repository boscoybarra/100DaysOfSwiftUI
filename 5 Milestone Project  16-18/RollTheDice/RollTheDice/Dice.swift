//
//  Dice.swift
//  RollTheDice
//
//  Created by J B on 03/04/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI


class Dice: ObservableObject {
    
    var value: Int {
        willSet {
            objectWillChange.send()
        }
    }
    private let sides: Int
    
    func roll() {
        self.value = Int.random(in: 1...sides)
    }
    
    init (sides: Int) {
        self.sides = sides
        self.value = Int.random(in: 1...sides)
    }
}


