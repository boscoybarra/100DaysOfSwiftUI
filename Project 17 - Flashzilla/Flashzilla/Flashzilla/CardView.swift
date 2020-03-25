//
//  CardView.swift
//  Flashzilla
//
//  Created by Bosco on 24/03/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    var body: some View {
        ZStack {
//            Responsive for acceseibility
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    Color.white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(
                        differentiateWithoutColor
                            ? Color.white
                            : Color.white
                                .opacity(1 - Double(abs(offset.width / 50)))

                    )
                    .background(
                        differentiateWithoutColor
                            ? nil
                            : RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(offset.width > 0 ? Color.green : Color.red)
                    )
                    .shadow(radius: 10)
                )
                .shadow(radius: 10)

            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)

                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }

                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        // remove the card
//                      Tip: That question mark in there means the closure will only be called if it has been set.
                        self.removal?()
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}