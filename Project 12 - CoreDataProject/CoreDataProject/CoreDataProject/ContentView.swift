//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Bosco on 27/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import SwiftUI

enum FilterType: String, CaseIterable {
    case equals = "=="
    case lessThan = "<"
    case beginsWith = "BEGINSWITH"
    case not = "NOT"
}


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @State private var filterType = FilterType.equals

    var body: some View {
        VStack {
//           This will work with generics
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, filterType: filterType) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
//            This workds with the Singer class only
//            FilteredList(filter: lastNameFilter)

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
            
            Picker("Predicate type", selection: $filterType) {
                ForEach(FilterType.allCases, id: \.self) { item in
                    Text(item.rawValue)
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
