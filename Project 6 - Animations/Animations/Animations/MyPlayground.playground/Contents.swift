import UIKit

var str = "Hello, playground"

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default)
        .scaleEffect(animationAmount)
    }
}

//For example, we could use .easeOut to make the animation start fast then slow down to a smooth stop:
.animation(.easeOut)

//    For example, this makes our button scale up quickly then bounce:
.animation(.interpolatingSpring(stiffness: 50, damping: 1))


//For more precise control, we can customize the animation with a duration specified as a number of seconds. So, we could get an ease-in-out animation that lasts for two seconds like this:
.animation(.easeInOut(duration: 2))

    
//When we say .easeInOut(duration: 2) we’re actually creating an instance of an Animation struct that has its own set of modifiers
.animation(
    Animation.easeInOut(duration: 2)
        .delay(1)
)


//We can also ask the animation to repeat a certain number of times, and even make it bounce back and forward by setting autoreverses to true. This creates a one-second animation that will bounce up and down before reaching its final size:
    
.animation(
    Animation.easeInOut(duration: 1)
        .repeatCount(3, autoreverses: true)
)

//For continuous animations, there is a repeatForever() modifier that can be used like this:
.animation(
    Animation.easeInOut(duration: 1)
        .repeatForever(autoreverses: true)
)


//Given how little work that involves, it creates a remarkably attractive effect!

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            // self.animationAmount += 1
        }
        .padding(40)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }
    }
}


struct ContentView: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        VStack {
//            This is why we can animate a Boolean changing: Swift isn’t somehow inventing new values between false and true, but just animating the view changes that occur as a result of the change.
//
//            These binding animations use the same animation() modifier that we use on views, so you can go to town with animation modifiers if you want to:
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)
//            These binding animations effectively turn the tables on implicit animations: rather than setting the animation on a view and implicitly animating it with a state change, we now set nothing on the view and explicitly animate it with a state change. In the former, the state change has no idea it will trigger an animation, and in the latter the view has no idea it will be animated – both work and both are important.

            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}


struct ContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
//            withAnimation {
//                self.animationAmount += 360
//            }
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}
