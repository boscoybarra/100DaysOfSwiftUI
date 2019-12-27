//
//  ContentView.swift
//  UnitToUnits
//
//  Created by J B on 13/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputAmount = ""
    @State private var fromUnit = 2
    @State private var toUnit = 1
    
    let fromUnits = ["seconds", "minutes", "hours"]
    let toUnits = ["seconds", "minutes", "hours"]
    let unitsInSeconds = [1.0, 60.0, 3600.0, 86400.0, 60480.0]
    
    var totalAmount: Double {
        let amountToConvert = Double(Int(inputAmount) ?? 0)
        let amountToMultiply = Double(Int(unitsInSeconds[fromUnit]))
        
        let amountInSeconds = amountToSeconds(unit: fromUnit, amountToConvert: amountToConvert, amountToMultiply: amountToMultiply)
        
        //Using Apple's measurement instance
        
        let measurementInSecond = Measurement(value: amountInSeconds, unit: UnitDuration.seconds)
        let desiredUnit = converToUnit(value: self.toUnits[toUnit], measurementInSecond: measurementInSecond)
        
        return desiredUnit.value
    }
    
    func amountToSeconds(unit:Int, amountToConvert:Double, amountToMultiply:Double) -> Double {
        switch unit {
        case 0:
            return amountToConvert
        case 1:
            return amountToConvert * amountToMultiply
        case 2:
            return amountToConvert * amountToMultiply
        case 3:
            return amountToConvert * amountToMultiply
        case 4:
            return amountToConvert * amountToMultiply
        default:
            return 0.0
        }
    }
    
    func converToUnit(value:String, measurementInSecond: Measurement<UnitDuration>) -> Measurement<UnitDuration> {
        switch value {
        case "hours":
            return measurementInSecond.converted(to: .hours)
        case "minutes":
            return measurementInSecond.converted(to: .minutes)
        case "seconds":
            return measurementInSecond.converted(to: .seconds)
        default:
            return measurementInSecond.converted(to: .nanoseconds)
            
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section(header: Text("Amount")) {
                    TextField("Enter \(fromUnits[fromUnit])", text: $inputAmount)
                        Picker("Convert from", selection: $fromUnit) {
                            ForEach(0..<fromUnits.count) {
                                Text("\(self.fromUnits[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select the convertion unit")) {
                    Picker("Convert to", selection: $toUnit) {
                        ForEach(0..<toUnits.count) {
                            Text("\(self.toUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                } .navigationBarTitle("Time Convertor")
                
                
                Section(header: Text("Total")) {
                    Text("\(totalAmount, specifier: "%.f") \(toUnits[toUnit])")
                }
                    
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
