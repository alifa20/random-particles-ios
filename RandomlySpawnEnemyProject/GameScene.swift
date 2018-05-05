//
//  GameScene.swift
//  AdvanceSpriteKitButtonProject
//
//  Created by Skyler Lauren on 9/2/17.
//  Copyright © 2017 SkyVan Labs. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SVLSpriteNodeButtonDelegate {
    
    var leftArrowButton: SVLSpriteNodeButton!
    var rightArrowButton: SVLSpriteNodeButton!
    var shootButton: SVLSpriteNodeButton!
    
    var ship: SKSpriteNode!
    
    var lastUpdateTime: TimeInterval = 0
    var shipSpeed: CGFloat = 10.0
    
    var timeFrame = 60;
    var maxNumberOfBubbles = 15
    //random logic
    var delay: TimeInterval = 0.5
    var timeSinceStart: TimeInterval = 0.0
    
    //MARK: - Scene Stuff
    override func didMove(to view: SKView) {
        
        leftArrowButton = childNode(withName: "leftArrowButton") as! SVLSpriteNodeButton
        
        rightArrowButton = childNode(withName: "rightArrowButton") as! SVLSpriteNodeButton
        
        shootButton = childNode(withName: "shootButton") as! SVLSpriteNodeButton
        shootButton.delegate = self
        
        ship = childNode(withName: "ship") as! SKSpriteNode
        shipSpeed = size.width/2.0
        asteroidSpawner(delay: 0.5)
    }
    
    func asteroidSpawner(delay: TimeInterval){
        removeAction(forKey: "spawnAsteroids")
        
        self.delay = delay
        
        let delayAction = SKAction.wait(forDuration: delay)
        let spawnAction = SKAction.run {
            self.spawnAsteroid()
        }
        
        let sequenceAction = SKAction.sequence([delayAction, spawnAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        
        run(repeatAction, withKey: "spawnAsteroids")
    }
    
        func checkValidLocation(_ newBubble: SKSpriteNode) -> Bool {
            for subview in (self.view?.subviews)! {
                if let existingBubble = subview as? SKSpriteNode {
                    if existingBubble.frame.intersects(newBubble.frame) {
                        return false
                    }
                }
            }
            return true
        }
    
    func spawnAsteroid(){
        if(self.children.count > maxNumberOfBubbles) {
            return
        }
        //size
        var asteroidSize = CGSize(width: 100, height: 70)
        
        let randomSize = arc4random() % 3
        
        switch randomSize {
        case 1:
            asteroidSize.width *= 1.2
            asteroidSize.height *= 1.2
        case 2:
            asteroidSize.width *= 1.5
            asteroidSize.height *= 1.5
        default:
            break
        }
        
        //position
        let y = size.height/2+asteroidSize.height/2
        
        //        var randomX = CGFloat(arc4random() % UInt32(size.width-asteroidSize.width))
        //        randomX -= size.width/2-asteroidSize.width/2
        let cSpots = [-1*(size.width/2-asteroidSize.width/2)
            ,-1*(size.width/4-asteroidSize.width/2)
            ,0
            ,size.width/4-asteroidSize.width/2
            ,size.width/2-asteroidSize.width/2]
        let randomX = cSpots[Int(arc4random() % 5)]
        
        
        //        var randomX = size.width/2-asteroidSize.width/2
        //        let colors = [UIColor.black, UIColor.blue, UIColor.blue, UIColor.green, UIColor.green, UIColor.green, UIColor.purple, UIColor.purple, UIColor.purple, UIColor.purple, UIColor.purple, UIColor.purple, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red];
        //        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
        //        let color = colors[randomIndex]
        
        let colors = ["black", "blue", "blue", "green", "green", "green", "purple", "purple", "purple", "purple", "purple", "purple", "red", "red", "red", "red", "red", "red", "red", "red"];
        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
        let color = colors[randomIndex]
        
        //init
        let asteroid = TouchableSKSpriteNode(imageNamed: color)
        asteroid.size = CGSize(width: 100.0,height: 100.0)
        //        let asteroid = TouchableSKSpriteNode(color: SKColor.brown, size: asteroidSize)
        asteroid.isUserInteractionEnabled = true
        asteroid.position = CGPoint(x: randomX, y: y)
        if checkValidLocation(asteroid) {
            print("valid")
            addChild(asteroid)
        } else {
            print("not valid")
        }
        //        addChild(asteroid)
        
        //move
        let moveDownAction = SKAction.moveBy(x: 0, y: -size.height-asteroid.size.height, duration: 20.0)
        let destroyAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([moveDownAction, destroyAction])
        asteroid.run(sequenceAction)
        
        //        //rotation
        //        var rotateAction = SKAction.rotate(byAngle: 1, duration: 1)
        //
        //        let randomRotation = arc4random() % 2
        //
        //        if randomRotation == 1  {
        //            rotateAction = SKAction.rotate(byAngle: -1, duration: 1)
        //        }
        
        //        let repeatForeverAction = SKAction.repeatForever(rotateAction)
        //        asteroid.run(repeatForeverAction)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
            return
        }
        
        let dt = currentTime - lastUpdateTime
        
        if leftArrowButton.state == .down{
            ship.position.x -= shipSpeed * CGFloat(dt)
        }
        
        if ship.position.x < -size.width/2+ship.size.width/2{
            ship.position.x = -size.width/2+ship.size.width/2
        }
        
        if rightArrowButton.state == .down{
            ship.position.x += shipSpeed * CGFloat(dt)
        }
        
        if ship.position.x > size.width/2-ship.size.width/2{
            ship.position.x = size.width/2-ship.size.width/2
        }
        
        //difficulty
        timeSinceStart += dt
        
        if timeSinceStart > 5 && delay > 0.4 {
            asteroidSpawner(delay: 0.4)
        } else if timeSinceStart > 10 && delay > 0.3 {
            asteroidSpawner(delay: 0.2)
        }
        
        lastUpdateTime = currentTime
    }
    
    func shoot(){
        let bullet = SKSpriteNode(color: SKColor.red, size: CGSize(width: 10, height: 20))
        bullet.position = ship.position
        bullet.position.y += ship.size.height/2 + bullet.size.height/2
        addChild(bullet)
        
        let moveUpAction = SKAction.moveBy(x: 0, y: size.height, duration: 1.0)
        let destroy = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveUpAction, destroy])
        
        bullet.run(sequence)
    }
    
    //MARK: - SVLSpriteNodeButtonDelegate
    func spriteButtonDown(_ button: SVLSpriteNodeButton){
        print("spriteButtonDown")
    }
    
    func spriteButtonUp(_ button: SVLSpriteNodeButton){
        print("spriteButtonUp")
    }
    
    func spriteButtonMoved(_ button: SVLSpriteNodeButton){
        print("spriteButtonMoved")
    }
    
    func spriteButtonTapped(_ button: SVLSpriteNodeButton){
        if button == shootButton {
            shoot()
        }
    }
}
