//
//  ContentView.swift
//  Bookworm
//
//  Created by J B on 21/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    
        var body: some View {
            VStack {
                List {
                    ForEach(students, id: \.id) { student in
                        Text(student.name ?? "Unknown")
                    }
                }
                
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!

                    let student = Student(context: self.moc)
                    student.id = UUID()
                    student.name = "\(chosenFirstName) \(chosenLastName)"
                    
//  Finally we need to ask our managed object context to save itself. This is a throwing function call, because in theory it might fail. In practice, nothing about what we’ve done has any chance of failing, so we can call this using try? – we don’t care about catching errors.
                    
                    try? self.moc.save()
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
