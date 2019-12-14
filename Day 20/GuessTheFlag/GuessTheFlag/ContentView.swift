//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by J B on 14/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            self.showingAlert = true
        }
    .alert(isPresented: $showingAlert, content: {
        Alert(title: Text("Mr.Alert"), message: Text("This is some basic text"), dismissButton: .default(Text("Ok")))
    })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
