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
    let obstacleCategory = 0x1 << 2
    let playercategory = 0x1 << 1
    let backgroundVelocity : CGFloat = 3.0
    let coinVelocity: CGFloat = 5.0
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
        self.addCoin()
       // addChild(player)
        
        // Create shape node to use during mouse interaction
        //let w = (self.size.width + self.size.height) * 0.05
        }
    
    func addCoin(){
        var coin = SKSpriteNode(imageNamed: "gold_coin")
        coin.setScale(0.15)
        
        //collision detection
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.categoryBitMask = UInt32(obstacleCategory)
        coin.physicsBody?.isDynamic = true
        coin.physicsBody?.contactTestBitMask = UInt32(playercategory)
        coin.physicsBody?.collisionBitMask = 0
        coin.physicsBody?.usesPreciseCollisionDetection = true
        coin.zPosition = 2
        coin.name = "coin"
        //random y position
        var random: CGFloat = CGFloat(arc4random_uniform(300))
        coin.position = CGPoint(x:self.frame.size.width , y: random)
        self.addChild(coin)
    }
    
    func initializingScrollBackground() {
        
        for index in 0...2{
            let bg = SKSpriteNode(imageNamed: "Back")
            bg.size = CGSize(width: screenWidth, height: screenHeight )
            bg.position = CGPoint(x: index * Int(bg.size.width), y: -200)
            bg.anchorPoint = CGPoint.zero
            bg.zPosition = 0
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
