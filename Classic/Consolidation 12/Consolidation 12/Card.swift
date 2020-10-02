//
//  Card.swift
//  Consolidation 12
//
//  Created by Vyacheslav Pronin on 02/10/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import Foundation

class Card {
    var faceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIndex() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIndex()
    }
}
