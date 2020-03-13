//
//  ContentView.swift
//  HotProspects
//
//  Created by J B on 09/03/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI
import SamplePackage


struct ContentView: View {
    let possibleNumbers = Array(1...60)
    
    var results: String {
//        Inside there we’re going to select seven random numbers from our range, which can be done using the extension you got from my SamplePackage framework. This provides a random() method that accepts an integer and will return up to that number of random elements from your sequence, in a random order. Lottery numbers are usually arranged from smallest to largest, so we’re going to sort them.
        let selected = possibleNumbers.random(7).sorted()
//        Next, we need to convert that array of integers into strings. This only takes one line of code in Swift, because sequences have a map() method that lets us convert an array of one type into an array of another type by applying a function to each element. In our case, we want to initialize a new string from each integer, so we can use String.init as the function we want to call.
        let strings = selected.map(String.init)
//        At this point strings is an array of strings containing the seven random numbers from our range, so the last step is to join them all together with commas in between. Add this final line to the property now:
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
