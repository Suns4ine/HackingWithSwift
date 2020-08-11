//
//  File.swift
//  Project 1
//
//  Created by Vyacheslav Pronin on 12/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import Foundation

class Cell: NSObject, Codable {
    var name: String
    var count: Int
    
    init(name: String) {
        self.name = name
        count = 0
    }
}
