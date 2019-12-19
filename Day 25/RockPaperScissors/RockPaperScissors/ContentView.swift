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
    
    @State private var appChoice = ""
    @State private var userChoice = ""
    
    var body: some View {
        HStack(alignment: .center, spacing: 30) {
            ForEach(self.emojiMoves, id: \.self ) {
                Button($0) {
                }
                .font(.system(size: 60))
                .clipShape(Rectangle())
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.purple, lineWidth: 5)
                )
//                .shadow(color: .black, radius: 5)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
