//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Bosco on 27/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import MapKit

//Users can now drop pins on our MapView, but they can’t do anything with them – they can’t attach their own title and subtitle. Fixing this requires a little bit of thinking, because MKPointAnnotation uses optional strings for title and subtitle, and SwiftUI doesn’t let us bind optionals to text fields.

//There are a couple of ways of fixing this, but the easiest one by far is writing an extension to MKPointAnnotation that adds computed properties around title and subtitle, which means we can then make the class conform to ObservableObject without any further work. You can call these computed properties whatever you want – name, info, details, etc – but you’ll probably find that marking them as simple wrappers works out easier to remember in the long term, which is why I’m going to use the names wrappedTitle and wrappedSubtitle.

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
