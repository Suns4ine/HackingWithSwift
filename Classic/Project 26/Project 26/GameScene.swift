//
//  GameScene.swift
//  Project 26
//
//  Created by Vyacheslav Pronin on 13/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    enum CollisionTypes: UInt32 {
        case player = 1
        case wall = 2
        case star = 4
        case vortex = 8
        case finish = 16
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    func loadLevel() {
        guard let levelURL = Bundle.main.url(forResource: "level1", withExtension: "txt") else {
            fatalError("Could not find level1.txt in the app bundle.")
        }
        guard let levelString = try? String(contentsOf: levelURL) else {
            fatalError("Could not load level1.txt from the app bundle.")
        }
        
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated() {
            for (colum, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * colum) + 32, y: (64 * colum) + 32)
                
                if letter == "x" {
                    let node = SKSpriteNode(imageNamed: "block")
                    node.position = position
                    
                    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                    node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                    node.physicsBody?.isDynamic = false
                    addChild(node)
                } else if letter == "v" {
                    
                } else if letter == "S" {
                    
                } else if letter == "f" {
                    
                } else if letter == " " {
                    
                } else {
                    fatalError("Unknown level letter: \(letter)")
                }
            }
        }
        
    }
}
