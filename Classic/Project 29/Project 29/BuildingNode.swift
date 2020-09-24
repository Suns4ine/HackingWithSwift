//
//  BuildingNode.swift
//  Project 29
//
//  Created by Vyacheslav Pronin on 24/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit
import SpriteKit

class BuildingNode: SKSpriteNode {

    var currentImage: UIImage!
    func setup() {
        name = "building"
        
        currentImage = drawBuilding(size: size)
    }
}
