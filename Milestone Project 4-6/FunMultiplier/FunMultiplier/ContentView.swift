//
//  ContentView.swift
//  FunMultiplier
//
//  Created by J B on 30/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI


struct Questions {
    let question: String
    let answer: Int
}

struct ContentView: View {
    
    @State private var multiplicationTable = 1
    @State private var defaultAmountOfQuestions = 0
    @State private var answer = ""
    
    let numberOfQuestions = [5, 10, 20, 35]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Form {
                    Section(header: Text("Select multiplication table 🧮")) {
                        Text("What multiplicaion table do you want to practice?")
                            .font(.headline)
                            Stepper(value: $multiplicationTable, in: 1...12, step: 1) {
                                Text("\(multiplicationTable) table")
                        }
                    }
                    
                    Section(header: Text("How many questions to you want to respond?")) {
                        Picker("Tip percentage", selection: $defaultAmountOfQuestions) {
                            ForEach(0 ..< numberOfQuestions.count) {
                                Text("\(self.numberOfQuestions[$0]) questions")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
//                    Responce fild
                    
//                    Section {
//                        Text("Your anwer is ...")
//                              .font(.caption)
//                              .foregroundColor(.secondary)
//
//                       TextField("Number of people", text: $answer) {
//
//                       }  .keyboardType(.numberPad)
//                           .font(.largeTitle)
//                    }
                }
                
               
            } // We can use onAppear() to run a closure when a view is shown.
            .onAppear(perform: startGame)
        .navigationBarTitle("Fun Multiplier")
        }
    }
    
    func startGame() -> Questions {
        ForEach(0 ..< defaultAmountOfQuestions) {
            Questions(question: "\($multiplicationTable) x \($0)", answer: $0 * multiplicationTable)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
