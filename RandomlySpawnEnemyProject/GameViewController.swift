//
//  GameViewController.swift
//  RandomlySpawnEnemyProject
//
//  Created by Skyler Lauren on 9/30/17.
//  Copyright © 2017 SkyVan Labs. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

//struct Settings {
////    let playTime: TimeInterval
//    let maxBubbles: Int
//}


struct Settings {
    let maxBubbles: Int
    //    let playTime: TimeInterval
    //    init(maxBubbles: Int, playTime: TimeInterval) {
    //        self.maxBubbles = maxBubbles
    //        self.playTime = playTime
    //    }
    init(maxBubbles: Int) {
        self.maxBubbles = maxBubbles
    }
}

class GameViewController: UIViewController, MenuSceneDelegate {
    func calledFromMenuScene(_ scene: MenuScene) {
        print("calledFromMenuScene")
    }
    var playerName: String?
    var settings: Settings?
    var startGame: SVLSpriteNodeButton2!
    
    //    func calledFromMenuScene(_ button: SVLSpriteNodeButton2) {
    //        print("calledFromMenuScene")
    ////        if let scene = SKScene(fileNamed: "GameScene") {
    ////            // Set the scale mode to scale to fit the window
    ////            scene.scaleMode = .aspectFill
    ////        }
    //    }
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var countdownTimer: Timer!
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "time"
        
        //        let menuScene = MenuScene()
        //        menuScene.scaleMode = .aspectFill
        //        menuScene.menuDelegate = self
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MenuScene") as? MenuScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.settings =  Settings(maxBubbles:10 )
                scene.playerName = self.playerName
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            startTimer()
        }
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        //        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        //        timer.fire()
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "FinishScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
        timerLabel.removeFromSuperview()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    //     func willMoveFromView(view: SKView) {
    //        timerLabel.removeFromSuperview()
    //    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.destination as? GameViewController {
            scene.playerName = "..."
            //            let s =  Settings(maxBubbles:10 )
            //            scene.settings = s
            //            scene.playerName = self.playerName
            //            scene.settings = self.settings
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
