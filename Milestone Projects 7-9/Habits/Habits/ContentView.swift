    //
//  ContentView.swift
//  Habits
//
//  Created by Bosco on 14/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI
    
struct HabitItem: Identifiable, Codable {
//  In this instance we’re going to ask Swift to generate a UUID automatically for us
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
    
class Habits: ObservableObject {
    @Published var habits: [HabitItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
}
    
    init() {
        if let habits = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([HabitItem].self, from: habits) {
                self.habits = decoded
                return
            }
        }

        self.habits = []
    }
}

struct ContentView: View {
    
    @ObservedObject var myHabits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(myHabits.habits) { item in
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
                    .sheet(isPresented: $showingAddHabit) {
                        AddView(myHabits: self.myHabits)
                    }
                    .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action: {
                                        self.$showingAddHabit = true
                                    }) {
                    //Inside the Button
                                        Image(systemName: "plus")
                                    }
                                )
                }
    }
    
    func removeItems(at offsets: IndexSet) {
        myHabits.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
