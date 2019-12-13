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
    @State private var unit = 2
    
    let units = ["seconds", "minutes", "hours", "days", "weeks"]
    let unitsInSeconds = [1.0, 60.0, 3600.0, 86400.0, 60480.0]
    
    var totalAmount: Double {
        let amountToConvert = Double(Int(inputAmount) ?? 0)
        let amountToDivide = Double(Int(unitsInSeconds[unit]))
        
        let amountInSeconds = amountToSeconds(unit: unit, amountToConvert: amountToConvert, amountToDivide: amountToDivide)
        
        let finalAmount = amountInSeconds
        
        return finalAmount
    }
    
    func amountToSeconds(unit:Int, amountToConvert:Double, amountToDivide:Double) -> Double {
        switch unit {
        case 0:
            return amountToConvert
        case 1:
            return amountToConvert * amountToDivide
        case 3:
            return amountToConvert * amountToDivide
        case 4:
            return amountToConvert * amountToDivide
        default:
            return 0.0
        }
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section(header: Text("Ex. Type your age")) {
                    TextField("Enter amount to convert", text: $inputAmount)
                }
                
                Section(header: Text("Select the convertion unit")) {
                    Picker("Convert to", selection: $unit) {
                        ForEach(0..<units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                } .navigationBarTitle("Time Convertor")
                
                
                Section(header: Text("Total")) {
                    Text("\(totalAmount, specifier: "%.2f") in \(units[unit])")
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
