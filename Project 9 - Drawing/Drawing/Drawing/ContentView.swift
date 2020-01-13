//
//  ContentView.swift
//  Drawing
//
//  Created by J B on 10/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(CGRect(x: rect.midX / 2, y: rect.midY, width: rect.width / 2, height: rect.width / 2))
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.midY))

        return path
    }
}

struct ContentView: View {
    
    @State private var widthOfLine: CGFloat = 10
    @State private var scaleAmount: CGFloat = 5
    @State private var rotationAngle: Double = 0
    @State private var strokeColor: Color = .yellow
    
    var body: some View {
        VStack(spacing: 30) {
            Arrow()
                .stroke(strokeColor, style: StrokeStyle(lineWidth: widthOfLine, lineCap: .round, lineJoin: .round))
            
            
            .onAppear {
                       withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                           self.scaleAmount = 0.6
                           self.rotationAngle = 720
                           self.widthOfLine = 20
                           self.strokeColor = .green
                       }
                       
                   }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
