//
//  ContentView.swift
//  Instafilter
//
//  Created by J B on 16/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
               self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
