//
//  TouchableSKSpriteNode.swift
//  RandomlySpawnEnemyProject
//
//  Created by Samaneh Fathieh on 5/5/18.
//  Copyright © 2018 SkyVan Labs. All rights reserved.
//


import SpriteKit

//protocol GameSceneDelegate {
//    func calledFromBubble(_ button: TouchableSKSpriteNode)
//}

protocol GameSceneDelegate: class {
    func calledFromBubble(_ button: TouchableSKSpriteNode)
}


class TouchableSKSpriteNode: SKSpriteNode {
    var scoreLabel: SKLabelNode!
    var bubbleType = ""
    
    //    var gameDelegate: GameSceneDelegate?
    weak var delegate: GameSceneDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        scoreLabel = self.parent?.childNode(withName: "scoreLabel") as! SKLabelNode
//        scoreLabel.text = String(Int(scoreLabel.text!)!+1)
        //        gameDelegate?.calledFromBubble(self)
        delegate?.calledFromBubble(self)
        self.removeFromParent()
    }
}
