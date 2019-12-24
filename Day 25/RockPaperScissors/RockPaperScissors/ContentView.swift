//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Bosco on 19/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let emojiMoves = ["🗿", "🧻", "✂️"]
    let textMoves = ["rock", "paper", "scissors"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var userChoice = Bool.random()
    
    var body: some View {
        HStack(alignment: .center, spacing: 30) {

            ForEach(self.emojiMoves, id: \.self ) {
                Button($0 == "🗿" ? "🗿" : $0 == "🧻" ? "🧻" : "✂️") {
                }
                .font(.system(size: 60))
                .clipShape(Rectangle())
                .padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 3)
                        
                )
                .shadow(color: .gray, radius: 6, x: 0, y: 4)
            }
        }
    }
}

//func shouldWin(_ emojiMoves: String) {
//        if emojiMoves == appChoice {
//            scoreTitle = "Correct"
//            storeScore += 1
//        } else {
//            scoreTitle = "Ups! This is the flag of \(countries[number])"
//            storeScore -= 1
//        }
//
//        showingScore = true
//   }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
