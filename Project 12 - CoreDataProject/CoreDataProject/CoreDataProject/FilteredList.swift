//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Bosco on 28/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import CoreData
import SwiftUI


// using filter view with generics so that we can pass any short of data

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}


// Only with Singer class

//struct FilteredList: View {
////    This will store our fetch request, so that we can loop over it inside the body.
//    var fetchRequest: FetchRequest<Singer>
//    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
//
//    var body: some View {
//        List(fetchRequest.wrappedValue, id: \.self) { singer in
//            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//        }
//    }
//
////   However, we don’t create the fetch request here, because we still don’t know what we’re searching for. Instead, we’re going to create a custom initializer that accepts a filter string and uses that to set the fetchRequest property.
//    init(filter: String) {
//        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
//    }
//}

// We delete this because we are creating our own view

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
