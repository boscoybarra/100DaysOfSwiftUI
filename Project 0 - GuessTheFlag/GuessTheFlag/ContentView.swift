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
    var number: Int
    var displayAnimation: Bool
    var selectedAnswer: Int
    var correctAnswer: Int
    
    func body(content: Content) -> some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)

            // Animations
            
            .overlay(Color.red.opacity(displayAnimation && number != correctAnswer ? 0.8 : 0)
                .cornerRadius(50))
            .opacity(displayAnimation && number != selectedAnswer ? 0.2 : 1)
            .rotation3DEffect(displayAnimation && number == selectedAnswer ? .degrees(360) : .degrees(0), axis: correctAnswer == selectedAnswer ? (x: 1, y: 1, z: 1) : (x: 0, y: 1, z: 0))
            .scaleEffect(displayAnimation && number == selectedAnswer ? 1.7 : 1)
            .animation(Animation.interpolatingSpring(stiffness: 7, damping: 3)
                .speed(5)
                .delay(0.5)
            )
            
    }
}

extension View {
    func flagModifier(with image: String, number: Int, displayAnimation: Bool,selectedAnswer: Int, correctAnswer: Int) -> some View {
        self.modifier(FlagImage(image: image, number: number, displayAnimation: displayAnimation,selectedAnswer: selectedAnswer, correctAnswer: correctAnswer))
    }
}



struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var storeScore = 0
    
    @State private var displayAnimation = false
    
    @State private var selectedAnswer = 0

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
                        self.displayAnimation = true
                        self.flagTapped(number)
                    })
                    {
                        self.flagModifier(with: self.countries[number], number: number, displayAnimation: self.displayAnimation,selectedAnswer: self.selectedAnswer, correctAnswer: self.correctAnswer)
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
            self.displayAnimation = false
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
        
        selectedAnswer = number

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
