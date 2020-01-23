//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Bosco on 17/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is $\(self.order.orderInfo.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
//        .alert(isPresented: $noInternetconfirmation) {
//            Alert(title: Text("Ups!"), message: Text(noInterntConnection), dismissButton: .default(Text("OK")))
//        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.orderInfo) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle the result here.
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                self.alertMessage = "\(error!.localizedDescription)"
                self.showingAlert = true
                self.alertTitle = "Ups!"
                
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderInfo.self, from: data) {
                print(data)
                self.alertMessage = "Your order for \(decodedOrder.quantity)x \(OrderInfo.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingAlert = true
                self.alertTitle = "Thank you!"
                
            }
            
            else {
                print("Invalid response from server")
                self.alertMessage = "\(error!.localizedDescription)"
                self.showingAlert = true
                self.alertTitle = "Ups!"
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
