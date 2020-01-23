//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Bosco on 16/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI


struct ContentView: View {
//  That’s the only place the order will be created – every other screen in our app will be passed that property so they all work with the same data.
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderInfo.type) {
                        ForEach(0..<OrderInfo.types.count, id: \.self) {
                            Text(OrderInfo.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.orderInfo.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderInfo.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.orderInfo.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if order.orderInfo.specialRequestEnabled {
                        Toggle(isOn: $order.orderInfo.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.orderInfo.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
