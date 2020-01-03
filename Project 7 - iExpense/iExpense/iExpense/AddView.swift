//
//  AddView.swift
//  iExpense
//
//  Created by J B on 01/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct AddView: View {
//    And now we can pass our existing Expenses object from one view to another – they will both share the same object, and will both monitor it for changes. We pass that info with this code in ConcetnView
    
//    .sheet(isPresented: $showingAddExpense) {
//        AddView(expenses: self.expenses)
//    }
    @ObservedObject var expenses: Expenses
    
    
    @Environment(\.presentationMode) var presentationMode
//    You’ll notice we don’t specify a type for that – Swift can figure it out thanks to the @Environment property wrapper.
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var showAlert = false

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showAlert = true
                }
            })
        }
        .alert(isPresented: $showAlert) {
        Alert(title: Text("Incorrect input"), message: Text("Your input \(self.amount) is not an number, please enter a correct value"), dismissButton: .default(Text("Continue")) {
            })
        }
    }
    
    
}
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
//        we can just pass in a dummy value instead
//        we dont have any code to show at first so we go to the + Button and tell Swift we have nothign to show
        AddView(expenses: Expenses())
    }
}
