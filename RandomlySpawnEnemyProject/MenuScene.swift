//
//  MenuScene.swift
//  RandomlySpawnEnemyProject
//
//  Created by Samaneh Fathieh on 5/5/18.
//  Copyright © 2018 SkyVan Labs. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var startGame: SKSpriteNode!

    override func didMove(to view: SKView) {
        startGame = childNode(withName: "startGame") as! SKSpriteNode
        startGame.color = .green
        print("Hey here")
    }
}
