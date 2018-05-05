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

class GameViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    
    var countdownTimer: Timer!
    var totalTime = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "time"
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "FinishScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
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
