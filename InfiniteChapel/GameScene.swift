//
//  GameScene.swift
//  InfiniteChapel
//
//  Created by Joseph Divalentone on 4/17/19.
//  Copyright © 2019 Joseph Divalentone. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    let playername = "Player"
    let randenemypos = Int.random(in: 0 ..< 2)
    let backgroundVelocity : CGFloat = 3.0
    public var screenWidth: CGFloat{
        return UIScreen.main.bounds.width
    }
    public var screenHeight: CGFloat{
        return UIScreen.main.bounds.height
    }
    
    var tapQueue = [Int]()
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        //creates border body and allows things to enter and exit
       // let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.initializingScrollBackground()
        let player = childNode(withName: "Player")as! SKSpriteNode
       // addChild(player)
        
        // Create shape node to use during mouse interaction
        //let w = (self.size.width + self.size.height) * 0.05
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
    
    func initializingScrollBackground() {
        
        for index in 0...2{
            let bg = SKSpriteNode(imageNamed: "Back")
            bg.size = CGSize(width: screenWidth, height: screenHeight )
            bg.position = CGPoint(x: index * Int(bg.size.width), y: -200)
            bg.anchorPoint = CGPoint.zero
            bg.name = "Back"
            self.addChild(bg)
        }
    }
    func moveBackground() {
        self.enumerateChildNodes(withName: "Back", using: {(node, stop) -> Void in
            if let bg = node as? SKSpriteNode{
                bg.position = CGPoint(x: bg.position.x - self.backgroundVelocity, y : bg.position.y)
                
                if bg.position.x <= -bg.size.width {
                    bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                }
            }
        })
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
        self.moveBackground()
    }
}
