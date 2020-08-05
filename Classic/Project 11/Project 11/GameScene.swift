//
//  GameScene.swift
//  Project 11
//
//  Created by Vyacheslav Pronin on 04/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
}
