//
//  AnimationView.swift
//  Milestone Projects 10-12
//
//  Created by J B on 05/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct AnimationView: View {
     @State var views = [AnyView]()

        var body: some View {
            VStack {
                Button("Add Shape") {
                    if Bool.random() {
                        self.views.append(Circle()
                            .frame(height: 50)
    //                       We are going to use AnyView extensenvely, we can ad an extension
                            .erasedToAnyView())
                    } else {
                        self.views.append(Rectangle()
                            .frame(width: 50)
                            .erasedToAnyView())
                    }
                }

    //          This add the view on the VStack
                ForEach(0..<views.count, id: \.self) {
                    self.views[$0]
                }

                Spacer()
            }
        }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}


extension View {
    func erasedToAnyView() -> AnyView {
        AnyView(self)
    }
}


//struct ContentView: View {
//    @State var views = [AnyView]()
//
//    var body: some View {
//        VStack {
//            Button("Add Shape") {
//                if Bool.random() {
//                    self.views.append(AnyView(Circle().frame(height: 50)))
//                } else {
//                    self.views.append(AnyView(Rectangle().frame(width: 50)))
//                }
//            }
//
////          This add the view on the VStack
//            ForEach(0..<views.count, id: \.self) {
//                self.views[$0]
//            }
//
//            Spacer()
//        }
//    }
//}


//struct ContentView: View {
//    var body: some View {
//        Group {
//            if Bool.random() {
//                Text("Hello, World!")
//                    .frame(width: 300)
//            } else {
//                Text("Hello, World!")
//            }
//        }
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        if Bool.random() {
//            return AnyView(Text("Hello, World!")
//                .frame(width: 300))
//        } else {
//            return AnyView(Text("Hello, World!"))
//        }
//    }
//}



