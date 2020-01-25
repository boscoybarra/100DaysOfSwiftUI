//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Bosco on 25/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct EmojiRatingView: View {
    
//    Notice how that specifically uses Int16, which makes interfacing with Core Data easier. And that’s the entire view done – it really is that simple.
    
    let rating: Int16

    var body: some View {
        switch rating {
        case 1:
            return Text("😴")
        case 2:
            return Text("😕")
        case 3:
            return Text("😐")
        case 4:
            return Text("🙂")
        default:
            return Text("🤩")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
