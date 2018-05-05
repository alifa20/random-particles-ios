//
//  MenuScene.swift
//  RandomlySpawnEnemyProject
//
//  Created by Samaneh Fathieh on 5/5/18.
//  Copyright © 2018 SkyVan Labs. All rights reserved.
//

import SpriteKit

protocol MenuSceneDelegate: class {
    func calledFromMenuScene(_ scene: MenuScene)
}

class MenuScene: SKScene {
    var startGame: SVLSpriteNodeButton2!
    var viewController: GameViewController!
    weak var menuDelegate: MenuSceneDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameSceneTemp =  GameScene(fileNamed: "GameScene")
        gameSceneTemp?.scaleMode = .aspectFill
        self.scene?.view?.presentScene(gameSceneTemp)
    }
    
    override func didMove(to view: SKView) {
    }
}
