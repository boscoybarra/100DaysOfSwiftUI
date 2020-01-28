//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Bosco on 28/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//
//

import Foundation
import CoreData

//Dynamically filtering @FetchRequest with SwiftUI

extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    var wrappedLastName: String {
        lastName ?? "Unknown"
    }

}
