//
//  Pointer.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/15/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import MapKit


class Pointer: NSObject, MKAnnotation {
    var title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, lat : Double, lng: Double) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate =  CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        super.init()
    }

    init(title: String, locationName: String, discipline: String, location: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate =  location
        
        super.init()
    }
}