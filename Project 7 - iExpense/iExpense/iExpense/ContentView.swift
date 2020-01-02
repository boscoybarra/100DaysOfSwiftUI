//
//  ContentView.swift
//  iExpense
//
//  Created by J B on 31/12/2019.
//  Copyright © 2019 Bosco Ybarra. All rights reserved.
//

import SwiftUI

//All we’ve done is add Identifiable to the list of protocol conformances, nothing more. This is one of the protocols built into Swift, and means “this type can be identified uniquely.” It has only one requirement, which is that there must be a property called id that contains a unique identifier. We just added that, so we don’t need to do any extra work – our type conforms to Identifiable just fine.


struct ExpenseItem: Identifiable, Codable {
//  In this instance we’re going to ask Swift to generate a UUID automatically for us
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

//    1. Attempt to read the “Items” key from UserDefaults.
//    2. Create an instance of JSONDecoder, which is the counterpart of JSONEncoder that lets us go from JSON data to Swift objects.
//    3. Ask the decoder to convert the data we received from UserDefaults into an array of ExpenseItem objects.
//    4. If that worked, assign the resulting array to items and exit.
//    5. Otherwise, set items to be an empty array.
    
//    With that change, we’ve written all the code needed to make sure our items are saved when the user adds them. However, it’s not effective by itself: the data might be saved, but it isn’t loaded again when the app relaunches.
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                //    It’s common to do a bit of a double take when you first see [ExpenseItem].self – what does the .self mean? Well, if we had just used [ExpenseItem], Swift would want to know what we meant – are we trying to make a copy of the class? Were we planning to reference a static property or method? Did we perhaps mean to create an instance of the class? To avoid confusion – to say that we mean we’re referring to the type itself, known as the type object – we write .self after it.
                
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}


struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            List {
                
//    because our expense items are now guaranteed to be identifiable uniquely, we no longer need to tell ForEach which property to use for the identifier – it knows there will be an id property and that it will be unique, because that’s the point of the Identifiable protocol.
//              ForEach(expenses.items, id: \.id) { item in
                ForEach(expenses.items) { item in
//                    This kind of layout is common on iOS: title and subtitle on the left, and more information on the right.
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("\(item.amount)€")
                            .foregroundColor(item.amount <= 10 ? .green : item.amount < 100 ? .orange : .red)

                    }
                }
                .onDelete(perform: removeItems)
            }
            
            .navigationBarTitle("iExpense")
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
            .navigationBarItems(leading: EditButton(), trailing:
                            Button(action: {
                                self.showingAddExpense = true
                            }) {
            //                   Inside the Button
                                Image(systemName: "plus")
                            }
                        )
        }
//        .alert(isPresented: $showingScore) {
//            Alert(title: Text(scoreTitle), message: Text("Your score is \(storeScore)"), dismissButton: .default(Text("Continue")) {
//            })
//        }
    }
    
    
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Storing user settings with UserDefaults


