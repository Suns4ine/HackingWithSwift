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
        let movementAmount: CGFloat = 1800
        
        switch Int.random(in: 0...3) {
        case 0:
            createFireworks(xMovement: 0, x: 512, y: bottomEdge)
            createFireworks(xMovement: 0, x: 512 - 200, y: bottomEdge)
            createFireworks(xMovement: 0, x: 512 - 100, y: bottomEdge)
            createFireworks(xMovement: 0, x: 512 + 100, y: bottomEdge)
            createFireworks(xMovement: 0, x: 512 + 200, y: bottomEdge)
        case 1:
            createFireworks(xMovement: 0, x: 512, y: bottomEdge)
            createFireworks(xMovement: -200, x: 512 - 200, y: bottomEdge)
            createFireworks(xMovement: -100, x: 512 - 100, y: bottomEdge)
            createFireworks(xMovement: 100, x: 512 + 100, y: bottomEdge)
            createFireworks(xMovement: 200, x: 512 + 200, y: bottomEdge)
        case 2:
            createFireworks(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
            createFireworks(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
            createFireworks(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
            createFireworks(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
            createFireworks(xMovement: movementAmount, x: leftEdge, y: bottomEdge)
        case 3:
            createFireworks(xMovement: -movementAmount, x: righitEdge, y: bottomEdge + 400)
            createFireworks(xMovement: -movementAmount, x: righitEdge, y: bottomEdge + 300)
            createFireworks(xMovement: -movementAmount, x: righitEdge, y: bottomEdge + 200)
            createFireworks(xMovement: -movementAmount, x: righitEdge, y: bottomEdge + 100)
            createFireworks(xMovement: -movementAmount, x: righitEdge, y: bottomEdge)
        default:
            break
        }
    }
    
    func createFireworks(xMovement: CGFloat, x: Int, y: Int) {
        
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.colorBlendFactor = 1
        firework.name = "firework"
        node.addChild(firework)
        
        switch Int.random(in: 0...2) {
        case 0:
            firework.color = .cyan
        case 1:
            firework.color = .green
        case 2:
            firework.color = .red
        default:
            break
        }
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: xMovement, y: 1000))
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        node.run(move)
        
        if let emitter = SKEmitterNode(fileNamed: "fuse") {
            emitter.position = CGPoint(x: 0, y: -22)
            node.addChild(emitter)
        }
        
        fireworks.append(node)
        addChild(node)
    }
}
