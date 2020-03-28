//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Bosco on 28/03/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        HStack {
//            VStack {
//                Text("@boscoy_")
//                Image("bosco-ybarra")
//                    .resizable()
//                    .frame(width: 64, height: 64)
//            }
//
//            VStack {
//                Text("Full name:")
//                Text("BOSCO YBARRA")
//                    .font(.largeTitle)
//            }
//        }
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@boscoy_")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("bosco-ybarra")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("Bosco Ybarra")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
