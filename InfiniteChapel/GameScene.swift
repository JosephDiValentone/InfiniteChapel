//
//  GameScene.swift
//  InfiniteChapel
//
//  Created by Joseph Divalentone on 4/17/19.
//  Copyright © 2019 Joseph Divalentone. All rights reserved.
//

import SpriteKit
import GameplayKit
let obstacleCategory = 0x1 << 2
let playercategory = 0x1 << 1

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    let playername = "Player"
    let randenemypos = Int.random(in: 0 ..< 2)
   
    let backgroundVelocity : CGFloat = 3.0
    let coinVelocity: CGFloat = 5.0
    
    var lastCoinAdded : TimeInterval = 0.0
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
        physicsWorld.contactDelegate = self
        
        self.initializingScrollBackground()
        let player = childNode(withName: "Player")as! SKSpriteNode
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = UInt32(playercategory)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.contactTestBitMask = UInt32(obstacleCategory)
        player.zPosition = 3
        player.position.y = 50
       // addChild(player)
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {self.touchDown(atPoint: t.location(in: self))}
    }
    func touchDown(atPoint pos: CGPoint){
        jump()
    }
    func jump(){
        Player?.texture = SKTexture(imageNamed: "Player")
        Player?.physicsBody?.applyImpulse(CGVector(dx:0, dy: 300))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
    func touchUp(atPoint pos : CGPoint) {
        Player?.texture = SKTexture(imageNamed: "Player")
        
    }
    
    
    
    
    
    
    
    func addCoin(){
        let coin = SKSpriteNode(imageNamed: "gold_coin")
        coin.setScale(0.15)
        
        //collision detection
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.categoryBitMask = UInt32(obstacleCategory)
        coin.physicsBody?.isDynamic = true
        //coin.physicsBody?.contactTestBitMask = UInt32(playercategory)
        coin.physicsBody?.collisionBitMask = 0
        coin.physicsBody?.usesPreciseCollisionDetection = true
        coin.physicsBody?.affectedByGravity = false
        coin.zPosition = 2
        coin.name = "coin"
        //random y position
        //let actualranY = random(min: coin.size.width, max:size.height-coin.size.height)
        let randomint = Int.random(in: 0..<200)
        let randomy: CGFloat = CGFloat(arc4random_uniform(UInt32(randomint)))
        coin.position = CGPoint(x: screenWidth, y: randomy)
        self.addChild(coin)
    }
    func moveCoin(){
        self.enumerateChildNodes(withName: "coin", using: {(node, stop) -> Void in
            if let obstacle = node as? SKSpriteNode{
                obstacle.position = CGPoint (x: obstacle.position.x - self.coinVelocity, y: obstacle.position.y)
                if obstacle.position.x < -500{
                    obstacle.removeFromParent()
                }
            }
        })
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
                
                if bg.position.x/2  <= -bg.size.width {
                    bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                }
            }
        })
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.categoryBitMask == UInt32(playercategory)) && (secondBody.categoryBitMask == UInt32(obstacleCategory)){
            print("intersecting")
            secondBody.node!.removeFromParent()
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
    
    

    
 
  

    
    
    override func update(_ currentTime: TimeInterval) {
        if currentTime - self.lastCoinAdded > 1 {
            self.lastCoinAdded = currentTime + 1
            self.addCoin()
        }
        
        
        
        self.moveBackground()
        self.moveCoin()
    }
}
