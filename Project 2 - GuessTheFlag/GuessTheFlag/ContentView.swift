//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by J B on 14/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct FlagImage: ViewModifier {
    var image: String
    
    func body(content: Content) -> some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

extension View {
    func flagModifier(with image: String) -> some View {
        self.modifier(FlagImage(image: image))
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var storeScore = 0

    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                     
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        self.flagModifier(with: self.countries[number])
                    }
                    
                }
                
                VStack(alignment: .center, spacing: 30) {
                    Text("""
                        Score: \(self.storeScore)
                        """)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        
                }
                
                Spacer()
                
                
            }
        }
        
    .alert(isPresented: $showingScore) {
        Alert(title: Text(scoreTitle), message: Text("Your score is \(storeScore)"), dismissButton: .default(Text("Continue")) {
            self.askQuestion()
        })
    }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            storeScore += 1
        } else {
            scoreTitle = "Ups! This is the flag of \(countries[number])"
            storeScore -= 1
        }

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}