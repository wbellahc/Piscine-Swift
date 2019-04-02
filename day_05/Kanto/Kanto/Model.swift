//
//  Model.swift
//  Kanto
//
//  Created by Wahiba BELLAHCENE on 4/1/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import Foundation
import MapKit

struct Data {
    static var places: [findLoc] = [
        findLoc(title: "42", subtitle: "une super école", coordinate: CLLocationCoordinate2D(latitude: 48.896701, longitude: 2.318544)),
        findLoc(title: "Boulangerie", subtitle: "très bons sandwich", coordinate: CLLocationCoordinate2D(latitude: 48.892689, longitude: 2.316982)),
        findLoc(title: "Pont Cardinet", subtitle: "la base", coordinate: CLLocationCoordinate2D(latitude: 48.887834, longitude: 2.314194)),
        findLoc(title: "Mamma Primi", subtitle: "pizza pasta !", coordinate: CLLocationCoordinate2D(latitude: 48.883533, longitude: 2.320591))
    ]
}

class findLoc: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
