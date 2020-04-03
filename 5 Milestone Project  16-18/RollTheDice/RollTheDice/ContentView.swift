//
//  ContentView.swift
//  RollTheDice
//
//  Created by Bosco on 01/04/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
//    First, we need to add a property to ContentView that creates and stores a single instance of the Prospects class:
    var dices = Dices()
    
    var body: some View {
        TabView {
            DiceView(filter: .rollDice)
                .tabItem {
                    Image(systemName: "square")
                    Text("Roll Dice")
                }
            DiceView(filter: .games)
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }
        }.environmentObject(dices)
//        Second, we need to post that property into the SwiftUI environment, so that all child views can access it. Because tabs are considered children of the tab view they are inside, if we add it to the environment for the TabView then all our ProspectsView instances will get that object.
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
