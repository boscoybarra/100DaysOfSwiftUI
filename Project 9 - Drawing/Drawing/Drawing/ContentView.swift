//
//  ContentView.swift
//  Drawing
//
//  Created by J B on 10/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
//                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
//                        self.color(for: value, brightness: 1),
//                        self.color(for: value, brightness: 0.5)
//                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
//  Important: The drawingGroup() modifier is helpful to know about and to keep in your arsenal as a way to solve performance problems when you hit them, but you should not use it that often. Adding the off-screen render pass might slow down SwiftUI for simple drawing, so you should wait until you have an actual performance problem before trying to bring in drawingGroup().
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    
        @State private var colorCycle = 0.0

        var body: some View {
            VStack {
                ColorCyclingCircle(amount: self.colorCycle)
                    .frame(width: 300, height: 300)

                Slider(value: $colorCycle)
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
