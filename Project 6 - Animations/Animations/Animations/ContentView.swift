//
//  ContentView.swift
//  Animations
//
//  Created by J B on 27/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var engine: CHHapticEngine?
    @State private var startActivity = true
    
    var body: some View {
        Button(self.startActivity ? "Start" : "Running!") {
            self.startActivity.toggle()
//            self.animationAmount += 1
        }
       
        .padding(40)
        .background(self.startActivity ? Color.green : Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(self.startActivity ? Color.green : Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
            
        )
        .onAppear {
            self.animationAmount = 2
        }.onAppear(perform: prepareHaptics)
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
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 2)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 2)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)

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
