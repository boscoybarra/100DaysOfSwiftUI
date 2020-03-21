//
//  ContentView.swift
//  Flashzilla
//
//  Created by Bosco on 21/03/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {

    
    var body: some View {
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
