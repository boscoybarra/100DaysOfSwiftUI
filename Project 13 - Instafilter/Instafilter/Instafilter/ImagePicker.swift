//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Bosco on 20/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
//   If you recall, we gave the Coordinator class a single property: let parent: ImagePicker. This means we need to create it with a reference to the image picker that owns it, so the coordinator can forward on interesting events. So, inside our makeCoordinator() method we’ll create a Coordinator object and pass in self.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
//  If you recall, using UIViewControllerRepresentable means that ImagePicker is already a SwiftUI view that we can place inside our view hierarchy. In this instance we’re wrapping UIKit’s UIImagePickerController, which lets the user select something from their photo library.
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
//  When that ImagePicker struct is created, SwiftUI will automatically call its makeUIViewController() method, which is what goes on to create and send back a UIImagePickerController. However, our code doesn’t actually respond to any events inside the image picker – the user can search for an image and select it to dismiss the view, but we don’t then do anything with it.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}
