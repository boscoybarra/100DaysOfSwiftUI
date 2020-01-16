    //
    //  ContentView.swift
    //  iExpense
    //
    //  Created by J B on 31/12/2019.
    //  Copyright © 2019 Bosco Ybarra. All rights reserved.
    //

    import SwiftUI

    //All we’ve done is add Identifiable to the list of protocol conformances, nothing more. This is one of the protocols built into Swift, and means “this type can be identified uniquely.” It has only one requirement, which is that there must be a property called id that contains a unique identifier. We just added that, so we don’t need to do any extra work – our type conforms to Identifiable just fine.


    struct HabitItem: Identifiable, Codable {
    //  In this instance we’re going to ask Swift to generate a UUID automatically for us
        let id = UUID()
        let name: String
        let type: String
        let amount: Int
    }

    class Habits: ObservableObject {
        @Published var items: [HabitItem] {
            didSet {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(items) {
                    UserDefaults.standard.set(encoded, forKey: "Habits")
                }
            }
        }
        init() {
            if let items = UserDefaults.standard.data(forKey: "Habits") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([HabitItem].self, from: items) {
                    self.items = decoded
                    return
                }
            }

            self.items = []
        }
    }


    struct ContentView: View {
        
        @ObservedObject var habits = Habits()
        @State private var showingAddExpense = false

        var body: some View {
            NavigationView {
                List {
                    ForEach(habits.items) { item in
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
                
                .navigationBarTitle("My Habits")
                .sheet(isPresented: $showingAddExpense) {
                    AddView(habits: self.habits)
                }
                .navigationBarItems(leading: EditButton(), trailing:
                                Button(action: {
                                    self.showingAddExpense = true
                                }) {
                                    Image(systemName: "plus")
                                }
                            )
            }
        }
        
        
        
        func removeItems(at offsets: IndexSet) {
            habits.items.remove(atOffsets: offsets)
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
