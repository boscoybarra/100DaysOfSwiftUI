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

// to write an image to the photo library and read the response, we need some sort of class that inherits from NSObject. Inside there we need a method with a precise signature that’s marked with @objc, and we can then call that from UIImageWriteToSavedPhotosAlbum().
class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

//Conclusion
//We created a SwiftUI view that conforms to UIViewControllerRepresentable.
//We gave it a makeUIViewController() method that created some sort of UIViewController, which in our example was a UIImagePickerController.
//We added a nested Coordinator class to act as a bridge between the UIKit view controller and our SwiftUI view.
//We gave that coordinator a didFinishPickingMediaWithInfo method, which will be triggered by UIKit when an image was selected.
//Finally, we gave our ImagePicker an @Binding property so that it can send changes back to a parent view.


struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
               self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
