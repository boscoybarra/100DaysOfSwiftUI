//
//  ContentView.swift
//  BetterRest
//
//  Created by Bosco on 20/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        
        // when you create a new Date instance it will be set to the current date and time
//        let now = Date()

        // create a second Date instance set to one day in seconds from now
//        let tomorrow = Date().addingTimeInterval(86400)

        // create a range from those two
//        let range = now ... tomorrow
        
        VStack {
        
            Form {
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
            }
            
            Form {
//                DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                
//              Simpler solution
                DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
//                .labelsHidden()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
