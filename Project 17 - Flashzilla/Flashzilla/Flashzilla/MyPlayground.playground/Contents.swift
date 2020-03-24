import UIKit

var str = "Hello, playground"


//How to use gestures in SwiftUI

struct ContentView: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in self.offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }

        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}


//Making vibrations with UINotificationFeedbackGenerator and Core Haptics


struct ContentView: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in self.offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }

        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
             
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

import SwiftUI
import CoreHaptics

struct ContentView: View {
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Hello, World!")
        .onAppear(perform: prepareHaptics)
        .onTapGesture(perform: complexSuccess)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 2)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 2)
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//        events.append(event)
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//Disabling user interactivity with allowsHitTesting()

struct ContentView: View {

    
    var body: some View {
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

// Triggering events repeatedly using a timer


struct ContentView: View {
    //1. It asks the timer to fire every 1 second.
    //2. It says the timer should run on the main thread.
    //3. It says the timer should run on the common run loop, which is the one you’ll want to use most of the time. (Run loops lets iOS handle running code while the user is actively doing something, such as scrolling in a list.)
    //4. It connects the timer immediately, which means it will start counting time.
    //5. It assigns the whole thing to the timer constant so that it stays alive.

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
//  Before we’re done, there’s one more important timer concept I want to show you: if you’re OK with your timer having a little float, you can specify some tolerance. This allows iOS to perform important energy optimization, because it can fire the timer at any point between its scheduled fire time and its scheduled fire time plus the tolerance you specify. In practice this means the system can perform timer coalescing: it can push back your timer just a little so that it fires at the same time as one or more other timers, which means it can keep the CPU idling more and save battery power.
    
//  let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            //            we need to catch the announcements by hand using a new modifier called onReceive(). This accepts a publisher as its first parameter and a function to run as its second, and it will make sure that function is called whenever the publisher sends its change notification.
            .onReceive(timer) { time in
                if self.counter == 5 {
                    //       Stop timer
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }

                self.counter += 1
            }
    }
}

//How to be notified when your SwiftUI app moves to the background

struct ContentView: View {

    var body: some View {
        Text("Hello, World!")
//      when we move app to the background and stop diplaying on the screen
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            print("Moving to the background!")
        }
//        user has re-activated your app and is your chance to continue any important work:
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            print("Moving back to the foreground!")
        }
//        You can even detect when the user took a screenshot, using userDidTakeScreenshotNotification
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
            print("User took a screenshot!")
        }
    }
    
//    Note
//There are so many of these that I can’t realistically list them all here, so instead here are two more to try out:

//UIApplication.significantTimeChangeNotification is called when the user changes their clock or when daylight savings time changes.
//UIResponder.keyboardDidShowNotification is called when the keyboard is shown.
//Each of these notifications works in exactly the same way: use onReceive() to catch notifications from the publisher, then take whatever action you want.
}

//Supporting specific accessibility needs with SwiftUI

struct ContentView: View {
//    That will be either true or false, and you can adapt your UI accordingly. For example, in the code below we use a simple green background for the regular layout, but when Differentiate Without Color is enabled we use a black background and add a checkmark instead:
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? Color.black : Color.green)
        .foregroundColor(Color.white)
        .clipShape(Capsule())
    }
}

//Another common option is Reduce Motion, which again is available in the simulator under Accessibility > Motion > Reduce Motion. When this is enabled, apps should should limit the amount of animation that causes movement on screen. For example, the iOS app switcher makes views fade in and out rather than scale up and down.

//With SwiftUI, this means we should restrict the use of withAnimation() when it involves movement, like this:

struct ContentView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale: CGFloat = 1

    var body: some View {
        Text("Hello, World!")
            .scaleEffect(scale)
            .onTapGesture {
                if self.reduceMotion {
                    self.scale *= 1.5
                } else {
                    withAnimation {
                        self.scale *= 1.5
                    }
                }
            }
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

//So, when Reduce Motion Enabled is true the closure code that’s passed in is executed immediately, otherwise it’s passed along using withAnimation(). The whole throws/rethrows thing is more advanced Swift, but it’s a direct copy of the function signature for withAnimation() so that the two can be used interchangeably.

struct ContentView: View {
    @State private var scale: CGFloat = 1

    var body: some View {
        Text("Hello, World!")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    self.scale *= 1.5
                }
            }
    }
}

//One last option you should consider supporting is Reduce Transparency, and when that’s enabled apps should reduce the amount of blur and translucency used in their designs to make doubly sure everything is clear.

//For example, this code uses a solid black background when Reduce Transparency is enabled, otherwise using 50% transparency:

struct ContentView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
            .foregroundColor(Color.white)
            .clipShape(Capsule())
    }
}


//Designing a single card view
