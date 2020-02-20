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
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
//        Custom bindings that rely on properties of our view need to be created inside the body property of the view, because Swift doesn’t allow one property to reference another. So, add this just inside the start of the body property:
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
//      Important: Now that there is some logic inside the body property, you must place return before the NavigationView, like this:
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)

// display the image
//  What’s actually happening here is that Swift is able to convert if someCondition into a special internal view type called ConditionalContent: it stores the condition and the true and false views, and can check it at runtime. However, if let creates a constant, and switch can have any number of cases, so neither can be used.
//                    if let image = image { CHANGE
                    if image != nil {
//                     So, the fix here is to replace if let with a simple condition, then rely on SwiftUI’s support for optional views:
//                        image CHANGE
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    // select an image
                    self.showingImagePicker = true
                }

                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)

                HStack {
                    Button("Change Filter") {
                        // change filter
                    }

                    Spacer()

                    Button("Save") {
                        // save the picture
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
