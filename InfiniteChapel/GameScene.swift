//
//  GameScene.swift
//  InfiniteChapel
//
//  Created by Joseph Divalentone on 4/17/19.
//  Copyright © 2019 Joseph Divalentone. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let playername = "Player"
    
    class GameScene: SKScene, SKPhysicsContactDelegate{
        // set up game scene here
        
        
        
        
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        //creates border body and allows things to enter and exit
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
        // add player as node
        let backg = childNode(withName: "Back") as! SKSpriteNode
        let player = childNode(withName: "Player")as! SKSpriteNode
       // addChild(player)
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
     
    }
    
    func touchMoved(toPoint pos : CGPoint) {
   
    }
    
    func touchUp(atPoint pos : CGPoint) {
 
        
    }
    

    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
