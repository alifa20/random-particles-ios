//
//  TouchableSKSpriteNode.swift
//  RandomlySpawnEnemyProject
//
//  Created by Samaneh Fathieh on 5/5/18.
//  Copyright © 2018 SkyVan Labs. All rights reserved.
//

import SpriteKit

class TouchableSKSpriteNode: SKSpriteNode {
    var scoreLabel: SKLabelNode!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scoreLabel = self.parent?.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = String(Int(scoreLabel.text!)!+1)
        self.removeFromParent()
    }
}
