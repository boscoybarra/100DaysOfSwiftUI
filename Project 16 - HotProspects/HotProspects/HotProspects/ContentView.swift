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
    
//    First, we need to add a property to ContentView that creates and stores a single instance of the Prospects class:
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }.environmentObject(prospects)
//        Second, we need to post that property into the SwiftUI environment, so that all child views can access it. Because tabs are considered children of the tab view they are inside, if we add it to the environment for the TabView then all our ProspectsView instances will get that object.
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
