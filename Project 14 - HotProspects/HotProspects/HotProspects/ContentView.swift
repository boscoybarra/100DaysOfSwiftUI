//
//  ContentView.swift
//  HotProspects
//
//  Created by J B on 09/03/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI


struct ContentView: View {

    var body: some View {
        Image("example")
//            SwiftUI gives us the interpolation() modifier that lets us control how pixel blending is applied./
        .interpolation(.none)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
