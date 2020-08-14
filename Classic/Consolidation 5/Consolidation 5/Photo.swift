//
//  Photo.swift
//  Consolidation 5
//
//  Created by Vyacheslav Pronin on 13/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

//import Foundation
import UIKit

class Photo: NSObject, Codable {
  var name: String
  var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
