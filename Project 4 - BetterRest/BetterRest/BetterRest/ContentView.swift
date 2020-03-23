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
//    @State private var wakeUp = Date()
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                    Form {
                        Section(header: Text("Sunrise 🌞")) {
                            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .datePickerStyle(WheelDatePickerStyle())
                        }
                        
                        Section(header: Text("Sleep 😴")) {
                            Text("Desired amount of sleep")
                                .font(.headline)
                                Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                                    Text("\(sleepAmount, specifier: "%g") hours")
                                    .accessibility(value: Text("\(sleepAmount) out of 12"))
                            }
                        }
                        
                        Section(header: Text("Caffeine ☕️")) {
                            Text("Daily coffee intake")
                                .font(.headline)
                            Stepper(value: $coffeeAmount, in: 0...20) {
                                if coffeeAmount == 1 {
                                    Text("1 cup")
                                } else {
                                    Text("\(coffeeAmount) cups")
                                }
                                } .labelsHidden()
                                .pickerStyle(WheelPickerStyle())
                        }
                    }.accessibility(value: Text("\(coffeeAmount) \(coffeeAmount == 1 ? "cup" : "cups")"))

                    Text("Your ideal 🛌 is")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    Text(calculateBedtime())
                        .font(.largeTitle)
                }
                .navigationBarTitle("BetterRest")
            }
        }
    
// If you try compiling that code you’ll see it fails, and the reason is that we’re accessing one property from inside another – Swift doesn’t know which order the properties will be created in, so this isn’t allowed.

// The fix here is simple: we can make defaultWakeTime a static variable, which means it belongs to the ContentView struct itself rather than a single instance of that struct. This in turn means defaultWakeTime can be read whenever we want, because it doesn’t rely on the existence of any other properties.

// So, change the property definition to this:
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        let bedTime: String
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

           let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            bedTime = formatter.string(from: sleepTime)
//            $alertTitle = "Your ideal bedtime is…"
            
        } catch {
            // something went wrong!
//            $alertTitle = "Error"
            bedTime = "Sorry, there was a problem calculating your bedtime."
        }
        
        return bedTime
    }
}
        
        // when you create a new Date instance it will be set to the current date and time
//        let now = Date()

        // create a second Date instance set to one day in seconds from now
//        let tomorrow = Date().addingTimeInterval(86400)

        // create a range from those two
//        let range = now ... tomorrow
        
//        VStack {
//
//            Form {
//                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
//                    Text("\(sleepAmount, specifier: "%g") hours")
//                }
//            }
//
//            Form {
//                DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                
//              Simpler solution
//                DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
//                .labelsHidden()
//            }
//        }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
