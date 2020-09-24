//
//  GameScene.swift
//  Project 29
//
//  Created by Vyacheslav Pronin on 22/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    enum CollisionTypes: UInt32 {
        case banana = 1
        case building = 2
        case player = 4
    }
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        
    }
}
