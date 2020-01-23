//
//  Address.swift
//  CupcakeCorner
//
//  Created by Bosco on 17/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderInfo.name)
                TextField("Street Address", text: $order.orderInfo.streetAddress)
                TextField("City", text: $order.orderInfo.city)
                TextField("Zip", text: $order.orderInfo.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.orderInfo.hasValidAddress == false || order.orderInfo.hasNoWhiteSpace == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
