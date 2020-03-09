//
//  RatingView.swift
//  Bookworm
//
//  Created by Bosco on 24/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
//                    RatingView is designed to be reusable – it’s the kind of thing you can take from this project and use in a dozen other projects
                .accessibility(label: Text("\(number == 1 ? "1 star" : "\(number) stars")"))
//                    Second, we can remove the .isImage trait, because it really doesn’t matter that these are images:
                .accessibility(removeTraits: .isImage)
//                    And finally, we should tell the system that each star is actually a button, so users know it can be tapped. While we’re here, we can make VoiceOver do an even better job by adding a second trait, .isSelected, if the star is already highlighted.
                .accessibility(addTraits: number > self.rating ? .isButton : [.isButton, .isSelected])

            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
