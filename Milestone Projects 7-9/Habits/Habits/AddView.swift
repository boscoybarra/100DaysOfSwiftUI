//
//  AddView.swift
//  Habits
//
//  Created by Bosco on 14/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var habits: Habits

    @Environment(\.presentationMode) var presentationMode
    
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
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = HabitItem(name: self.name, type: self.type, amount: actualAmount)
                    self.habits.items.append(item)
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
        AddView(habits: Habits())
    }
}
