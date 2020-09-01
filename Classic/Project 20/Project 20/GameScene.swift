//
//  GameScene.swift
//  Project 20
//
//  Created by Vyacheslav Pronin on 01/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gameTimer: Timer?
    var fireworks = [SKNode]()
    
    var leftEdge = -22
    var bottomEdge = -22
    let righitEdge = 1024 + 22
    
    var score = 0 {
        didSet {
            
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)

    }
    
    @objc func launchFireworks() {
        
    }
}
