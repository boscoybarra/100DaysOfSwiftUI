//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Bosco on 27/01/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var director: String?
    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    
    
//  Instead, you might want to consider adding computed properties that help us access the optional values safely, while also letting us store your nil coalescing code all in one place. For example, adding this as a property on Movie ensures that we always have a valid title string to work with:
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
//  This way the whole rest of your code doesn’t have to worry about Core Data’s optionality, and if you want to make changes to default values you can do it in a single file.

}
