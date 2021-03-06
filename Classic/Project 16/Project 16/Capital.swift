//
//  Capital.swift
//  Project 16
//
//  Created by Vyacheslav Pronin on 28/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var site: URL
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, site: URL) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.site = site
    }
}
