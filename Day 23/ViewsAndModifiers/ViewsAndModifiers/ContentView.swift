//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Bosco on 17/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
//            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct BigTitles: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        Text(text)
                .font(.largeTitle)
                .foregroundColor(.blue)
    }
}

extension View {
    func bigTitles(with text: String) -> some View {
        self.modifier(BigTitles(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            
            bigTitles(with: "Hello world!")
            
            VStack(spacing: 10) {
                CapsuleText(text: "First")
                    .foregroundColor(.white)
                CapsuleText(text: "Second")
                    .foregroundColor(.pink)
                
             Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
