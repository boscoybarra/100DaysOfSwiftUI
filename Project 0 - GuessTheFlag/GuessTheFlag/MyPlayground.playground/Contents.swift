import UIKit

var str = "Hello, playground"

//        VStack(spacing: 20) {
//            Text("Hello World")
//            Text("This is inside a stack")
//        }
//
//        VStack {
//            Text("First")
//            Text("Second")
//            Text("Third")
//            Spacer()
//        }
        
        HStack {
            VStack {
                Text("First")
                Text("Second")
                Text("Third")
                Spacer()
            }
        }
        

        
//        VStack(alignment: .leading) {
//            Text("Hello World")
//            Text("This is inside a stack")
//        }
    

//If you want your content to go under the safe area, you can use the edgesIgnoringSafeArea() modifier to specify which screen edges you want to run up to. For example, this creates a ZStack which fills the screen edge to edge with red then draws some text on top:

ZStack {
    Color.red.edgesIgnoringSafeArea(.all)
    Text("Your content")
}

// We can specify the devices we want the condition to include.


//Color

Color(red: 1, green: 0.8, blue: 0)

//Frame in color
Color.red.frame(width: 200, height: 200)


//Gradientes
LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)

RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)

AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)


//Buttons and Colors example with .renderingMode option to have the defatil original button color

    ZStack {
        Color.blue.edgesIgnoringSafeArea(.all)
        Color.red.frame(width: 200, height: 50)
        LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)

        Button(action: {
            print("Button was tap!")
        }) {
            HStack(spacing: 10) {
                Image(systemName: "pencil").renderingMode(.original)
                Text("Edit")
        }
    }
}
