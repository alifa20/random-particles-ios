//
//  SVLSpriteNodeButton.swift
//  AdvanceSpriteKitButtonProject
//
//  Created by Skyler Lauren on 9/2/17.
//  Copyright © 2017 SkyVan Labs. All rights reserved.
//

import SpriteKit

protocol SVLSpriteNodeButtonDelegate: class {
    func spriteButtonDown(_ button: SVLSpriteNodeButton)
    func spriteButtonUp(_ button: SVLSpriteNodeButton)
    func spriteButtonMoved(_ button: SVLSpriteNodeButton)
    func spriteButtonTapped(_ button: SVLSpriteNodeButton)
}

class SVLSpriteNodeButton: SKSpriteNode {

    enum SpriteButtonState {
        case up
        case down
    }
    
    weak var delegate: SVLSpriteNodeButtonDelegate?
    var label: SKLabelNode?
    
    var state = SpriteButtonState.up
    
    //MARK: - Init and Setup
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        isUserInteractionEnabled = true
        
        for child in children{
            if let label = child as? SKLabelNode{
                self.label = label
            }
        }
    }
    
    //MARK: - Touch Logic
    func touchDown(atPoint pos : CGPoint) {
        alpha = 0.5
        state = .down
        delegate?.spriteButtonDown(self)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        delegate?.spriteButtonMoved(self)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        alpha = 1.0
        state = .up
        
        delegate?.spriteButtonUp(self)
        
        if contains(pos){
            delegate?.spriteButtonTapped(self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if parent != nil {
                self.touchUp(atPoint: t.location(in: parent!))
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if parent != nil {
                self.touchUp(atPoint: t.location(in: parent!))
            }
        }
    }
    
}
