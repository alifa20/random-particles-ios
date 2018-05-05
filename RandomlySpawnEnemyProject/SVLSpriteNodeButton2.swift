//
//  SVLSpriteNodeButton2.swift
//  RandomlySpawnEnemyProject
//
//  Created by Ali on 5/5/18.
//  Copyright © 2018 SkyVan Labs. All rights reserved.
//

import SpriteKit

protocol SVLSpriteNodeButton2Delegate: class {
    func calledFromSVLSpriteNodeButton2Delegate(_ button: SVLSpriteNodeButton2)

//    func spriteButtonUp(_ button: SVLSpriteNodeButton)
//    func spriteButtonMoved(_ button: SVLSpriteNodeButton)
//    func spriteButtonTapped(_ button: SVLSpriteNodeButton)
}



class SVLSpriteNodeButton2: SKSpriteNode {
    
    weak var delegate: SVLSpriteNodeButton2Delegate?
    func touchDown(atPoint pos : CGPoint){
        print ("Touch Down")
    }
    
    func touchMoved(atPoint pos : CGPoint){
        print ("Touch Moved")
    }
    
    func touchUp(atPoint pos : CGPoint){
        print ("Touch Up")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("tiouched")
//        delegate?.calledSVLSpriteNodeButton2Delegate(self)
        for t in touches {self.touchDown(atPoint: t.location(in: self))}
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {self.touchMoved(atPoint: t.location(in: self))}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {self.touchUp(atPoint: t.location(in: self))}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {self.touchUp(atPoint: t.location(in: self))}
    }
    

}
