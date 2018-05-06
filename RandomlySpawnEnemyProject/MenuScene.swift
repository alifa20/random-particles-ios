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
    var TextInput:UITextField?
    let slider = UISlider(frame: CGRect(x: 10, y: 250, width: 280, height: 20))
    let slider2 = UISlider(frame: CGRect(x: 10, y: 150, width: 280, height: 20))
    let labelSlider = UILabel (frame: CGRect (x: 10, y: 230, width: 280, height: 20))
    let labelSlider2 = UILabel (frame: CGRect (x: 10, y: 130, width: 280, height: 20))
    let textField = UITextField(frame: CGRect(x: 10, y: 400, width: 280, height: 50))
    
    var playerName: String?
    var settings: Settings?
    
    override func didMove(to view: SKView) {
        loadSlider()
        loadTextInput()
        
        
    }
    
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            let positionInScene = t.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "startGame"
                {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let gameSceneTemp =  GameScene(fileNamed: "GameScene") as GameScene?
                    gameSceneTemp?.scaleMode = .aspectFill
                    gameSceneTemp?.settings =  Settings(maxBubbles:Int(slider2.value), playTime: TimeInterval(slider.value))

                    gameSceneTemp?.playerName = self.playerName
                    self.scene?.view?.presentScene(gameSceneTemp!, transition: transition)
                   
                    slider.removeFromSuperview()
                    labelSlider.removeFromSuperview()
                    slider2.removeFromSuperview()
                    labelSlider2.removeFromSuperview()
                    textField.removeFromSuperview()
                }
            }
        }
    }
    
    private func loadTextInput() {
//        let textFieldFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 30))
//        textField.frame = textFieldFrame
        textField.backgroundColor = UIColor.white
        textField.placeholder = "Player1"
        view?.addSubview(textField)
    }
    
    private func loadSlider() {
        //        slider.addTarget(self, action:  "sliderValueDidChange", for: .valueChanged)
        
        slider.addTarget(self, action: #selector(MenuScene.slider1ValueDidChange(_:)), for: .valueChanged)
        
        //        slider2.addTarget(self, action: "sliderValueDidChange", for: .valueChanged)
        slider2.addTarget(self, action: #selector(MenuScene.slider2ValueDidChange(_:)), for: .valueChanged)
        view?.addSubview(slider)
        view?.addSubview(labelSlider)
        view?.addSubview(slider2)
        view?.addSubview(labelSlider2)
    }
    
  
    
    @objc func slider2ValueDidChange(_ sender:UISlider!)
    {
        var time = round(sender.value*60)
        if time < 10 {
            time = 10
        }
        labelSlider2.text = String(time)
        print("\(sender.value)")
    }
    
    @objc func slider1ValueDidChange(_ sender:UISlider!)
    {
        let number = round(sender.value*15)
      
        labelSlider.text = String(number)
        print("\(sender.value)")
    }
    
}
