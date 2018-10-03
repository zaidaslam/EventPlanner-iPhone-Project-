//
//  Pin.swift
//  EventPlanner
//
//  Created by Zaid Aslam Shaikh on 9/22/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class MapPin: NSObject, MKAnnotation {
    let title: String?
    let name: String
    let foursquareId: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, name: String, foursquareId: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.name = name
        self.foursquareId = foursquareId
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return name
    }
    
    func mapItem() -> MKMapItem {
        let placemark = MKPlacemark(coordinate: coordinate)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        
        return mapItem
    }
}
