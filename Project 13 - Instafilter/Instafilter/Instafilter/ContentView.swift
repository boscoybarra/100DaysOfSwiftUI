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
    @State private var radiusIntensity = 0.5
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var currentFilterName = "Add filter"
    
//    "Now using \(self.currentFilter.name)"
    
//   Adding that explicit type annotation means we’re throwing away some data: we’re saying that the filter must be a CIFilter but doesn’t have to conform to CISepiaTone any more.
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
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
        let radius = Binding<Double>(
            get: {
                self.radiusIntensity
            },
            set: {
                self.radiusIntensity = $0
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
                    Slider(value: radius)
                }.padding(.vertical)
                
                HStack {
                    Text("Radius")
                    Slider(value: radius)
                }.padding(.vertical)

                HStack {
                    Button(self.currentFilterName) {
                        // change filter
                        self.showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.showingAlert = true
                            return
                        }
                        
                        let imageSaver = ImageSaver()

                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("No image selected!"), message: Text("Please, select an imagine for filter to apply"), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
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
//By jettisoning the CISepiaTone restriction for our filter, we’re now forced to send values in using setValue(_:forKey:), which provides no safety at all. In this case, the Gaussian Blur filter doesn’t have an intensity value, so the app just crashes.

//To fix this – and also to make our single slider do much more work – we’re going to add some more code that reads all the valid keys we can use with setValue(_:forKey:), and only sets the intensity key if it’s supported by the current filter. Using this approach we can actually query as many keys as we want, and set all the ones that are supported. So, for sepia tone this will set intensity, but for Gaussian blur it will set the radius (size of the blur), and so on.
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(radiusIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        self.currentFilterName = "Current filter: \((currentFilter.name).dropFirst(2))"
        loadImage()
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
