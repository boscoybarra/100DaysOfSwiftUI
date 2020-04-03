//
//  DiceView.swift
//  RollTheDice
//
//  Created by J B on 03/04/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    @EnvironmentObject var dices: Dices
    
    enum FilterType {
        case rollDice, games
    }
    
    enum SortProspects {
        case name, date
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .rollDice:
            return "Everyone"
        case .games:
            return "Games"
        }
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(filter: .rollDice)
    }
}


