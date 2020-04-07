//
//  DiceView.swift
//  RollTheDice
//
//  Created by J B on 03/04/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    

    var body: some View {
        TabView{
            ZStack {
                    RollDiceView()
                    .tabItem {
                        Image(systemName: "square")
                        Text("Roll")
                        }
            }
            HistoryDiceRolls()
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("Results")
                    }
                }
            }
        }

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}


