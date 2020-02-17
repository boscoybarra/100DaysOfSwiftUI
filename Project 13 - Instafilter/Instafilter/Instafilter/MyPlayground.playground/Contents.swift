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
