//
//  MapView.swift
//  BucketList
//
//  Created by Bosco on 24/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import MapKit
import SwiftUI

//That creates a new typealias – a type name – called “Context”, and wherever Swift sees Context in code it will consider it the same as UIViewRepresentableContext<Self>, where Self is whatever type we’re working with. In practical terms, this means we can just write Context rather than UIViewRepresentableContext<MapView>, and they mean exactly the same thing.

struct MapView: UIViewRepresentable {
//  Just like working with UIImagePickerController, this means creating a nested class that inherits from NSObject, making it conform to whatever delegate protocol our view or view controller works with, and giving it a reference to the parent struct so it can pass data back up to SwiftUI.
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
//  Just as with the UIViewControllerRepresentable protocol, that means adding a method called makeCoordinator() that sends back a configured instance of our Coordinator. This should be added to the MapView struct, and it will send itself to the coordinator so it can report back what’s happening.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
//  Remember, our coordinator is the delegate of the map view, which means when something interesting happens it gets notified – when the map moves, when it starts and finishes loading, when the user was located on the map, when a map pin was touched, and so on.
        mapView.delegate = context.coordinator
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of England"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        mapView.addAnnotation(annotation)

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
