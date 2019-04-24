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
    let randenemypos = Int.random(in: 0 ..< 2)
    
    var tapQueue = [Int]()
    
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
    
    func throwTheEnemys (){
        var enemy: SKNode
        switch(randenemypos){
        case 0 :
            let startpoint = 0
        case 1 :
            let startpoint = 0
        case 2 :
            let startpoint = 0
            
        default : break
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    //help users tap
    func processUserTaps(forUpdate currentTime: CFTimeInterval){
        for tapCount in tapQueue{
            if tapCount == 1 {
                // jump function
            }
            tapQueue.remove(at: 0)
        }
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
     
    }
    
    func touchMoved(toPoint pos : CGPoint) {
   
    }
    
    func touchUp(atPoint pos : CGPoint) {
 
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (touch.tapCount == 1){
                tapQueue.append(1)
            }
        }
    }

    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
