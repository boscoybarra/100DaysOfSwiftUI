//
//  ContentView.swift
//  RollTheDice
//
//  Created by Bosco on 01/04/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var scores = UserScore()
    
//    First, we need to add a property to ContentView that creates and stores a single instance of the Prospects class:
    
    var body: some View {
        TabView {
            RollDiceView()
                .tabItem {
                    Image(systemName: "square")
                    Text("Roll Dice")
                }
            HistoryDiceRolls()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }
        }.environmentObject(scores)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
