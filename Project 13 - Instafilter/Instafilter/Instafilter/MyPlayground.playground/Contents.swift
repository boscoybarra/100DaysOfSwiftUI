import UIKit

var str = "Hello, playground"


struct ContentView: View {
    
//    Now let’s go a stage further: you’ve just seen how State wraps its value using a non-mutating setter, which means neither blurAmount or the State struct wrapping it are changing – our binding is directly changing the internally stored value, which means the property observer is never being triggered.

//How then can we solve this – how can we attach some functionality to a wrapped property? For that we need custom bindings – let’s look at that next…
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)
        }
    }
}


//Creating custom bindings in SwiftUI

//KEY:  if you want to make sure you update UserDefaults every time a value is changed, the set closure of a Binding is perfect.

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
//          Inside de value we pass here "blur" is the only thing that changes
            Slider(value: blur, in: 0...20)
        }
    }
}


//Showing multiple options with ActionSheet

struct ContentView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white

    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                .default(Text("Red")) { self.backgroundColor = .red },
                .default(Text("Green")) { self.backgroundColor = .green },
                .default(Text("Blue")) { self.backgroundColor = .blue },
                .cancel()
            ])
        }
    }
}


//Integrating Core Image with SwiftUI

struct ContentView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
//        To demonstrate this, we could replace our sepia tone with a pixellation filter like this:
//
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 100
        
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.radius = 200
        
//        For example, here’s how we would use a twirl distortion:
//
//        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
//        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)

        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}


//Using coordinators to manage SwiftUI view controllers
//How to save images to the user’s photo library

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


// Image Picker Code:

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
//        That does three things:
//        It makes the class inherit from NSObject, which is the parent class for almost everything in UIKit. NSObject allows Objective-C to ask the object what functionality it supports at runtime, which means the image picker can say things like “hey, the user selected an image, what do you want to do?”
//        It makes the class conform to the UIImagePickerControllerDelegate protocol, which is what adds functionality for detecting when the user selects an image. (NSObject lets Objective-C check for the functionality; this protocol is what actually provides it.)
//        It makes the class conform to the UINavigationControllerDelegate protocol, which lets us detect when the user moves between screens in the image picker.
        
        
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
//        That method receives a dictionary where the keys are of the type UIImagePickerController.InfoKey, and the values are of the type Any. It’s our job to dig through that to find the image that was selected, assign it to our parent, then dismiss the image picker.
        {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    
    }
//    What we need here is SwiftUI’s @Binding property wrapper, which allows us to create a binding from ImagePicker up to whatever created it. This means we can set the binding value in our image picker and have it actually update a value being stored somewhere else – in ContentView, for example.
    @Binding var image: UIImage?
    
//    While you’re there, we also want to dismiss this view when an image is chosen. Right now we aren’t handling image selection at all, so we get UIKit’s default dismissing behavior, but as soon as we inject some custom functionality we need to handle dismissal by hand.
//    So, add this second property to ImagePicker so we can dismiss the view programmatically:
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}

// How to save images to the user’s photo library

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

//Key Ideas Learned

//The @objc attribute lets Objective-C code call a Swift method.
//@objc tells Swift to create a method that can be read by Objective-C.

// We can place optional views directly into a SwiftUI view hierarchy.
//SwiftUI will only render them if they have a value.

//When creating a custom Binding, we must specify both a get closure and a set closure.

//Calling UIImageWriteToSavedPhotosAlbum() will fail if the user denied access to their photo library.

//Action sheets can have a title and/or message.
//Both should be text views.

//We can ask the user to select a photo from their library using UIImagePickerController.
//They can browse for whatever picture they want, or press Cancel.

//We can detect when an @State property changes using a property observer.
//This doesn't work; we need to use a custom binding instead.

//To make a SwiftUI view wrap a UIKit view controller, we must make it conform to UIViewControllerRepresentable.
//UIViewControllerRepresentable already conforms to View.

//All Core Image filters do not take the same range of input keys.
//They each take their own input keys, and trying to provide a key that isn't supported will cause a crash.

//KEY KEY KEY

//A coordinator class lets us handle communication back from a UIKit view controller.
//Coordinators act as bridges between SwiftUI's views and UIKit's view controllers.

//KEY KEY KEY

//SwiftUI's views work great as @State properties.

//Alerts and action sheets DO NOT look the same on iPhone.
//Alerts appear in the center of the screen, whereas action sheets slide up from the bottom.

//The @Binding property wrapper creates a Binding struct.
//This is all that property wrappers do behind the scenes.

//The Binding struct is generic.
//This means we don't create bindings without further context, but instead say "this is a binding for a string".

//Action sheets can have more buttons than alerts.
//They take an array of buttons, and can even scroll if needed.

//UIImage and CIImage are not the same.
//They are both different from each other, and also from CGImage.

//Core Image lets us apply graphical filters to an image.
//It performs the transformation in the GPU, which is what makes it so fast on devices.

// SwiftUI coordinators can act as delegates for another class.
//SwiftUI coordinators are specifically designed to act as delegates for another class.

//We attach code to run when an action sheet button is tapped by providing a closure.
//This works just like buttons in alerts.

//SwiftUI coordinator classes do not need to be nested inside a struct.
//They don't need to be nested, it's just nice to have.

//It's a good idea to create a CIContext once and re-use it.
//Reusing your CIContext is important for performance.
