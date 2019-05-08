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
let BorderCategory : UInt32 = 0x1 << 3

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    let playername = "Player"
    var player: SKSpriteNode?
    var score = 0
    var walkframe: [SKTexture] = []
    let randenemypos = Int.random(in: 0 ..< 2)
    let Coincount = "coinCount"
   
    let backgroundVelocity : CGFloat = 3.0
    let coinVelocity: CGFloat = 10.0
    
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
        print (screenHeight)
        
        print(UIScreen.main.bounds)
        let rec1 = UIScreen.main.bounds
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
         physicsWorld.contactDelegate = self
        self.initializingScrollBackground()
        player = (childNode(withName: "Player")as? SKSpriteNode)!
        player!.physicsBody = SKPhysicsBody(rectangleOf: player!.size)
        player!.setScale(0.75)
        player!.physicsBody?.categoryBitMask = UInt32(playercategory)
        player!.physicsBody?.isDynamic = true
        player!.physicsBody?.allowsRotation = false
        player!.physicsBody?.affectedByGravity = true
        player!.physicsBody?.contactTestBitMask = UInt32(obstacleCategory)
        player!.zPosition = 2
        player!.position.y = 50
        borderBody.categoryBitMask = BorderCategory
        player!.physicsBody!.contactTestBitMask = BorderCategory | UInt32(obstacleCategory)
        setupCount()
        }

    
    func adjustScore(by points:Int){
        score += points
        if let score = childNode(withName:Coincount) as? SKLabelNode {
            score.text = String(format: "Jesus Points: %04u", self.score)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {self.touchDown(atPoint: t.location(in: self))}
    }
    func touchDown(atPoint pos: CGPoint){
        jump()
    }
    func jump(){
        player!.texture = SKTexture(imageNamed: "Mario_Jump")
        player!.physicsBody?.applyImpulse(CGVector(dx:0, dy: 50))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
    func touchUp(atPoint pos : CGPoint) {
        player!.texture = SKTexture(imageNamed: "Unknownm")
    }
    func setupCount(){
        let coinC = SKLabelNode(fontNamed: "Courier")
        coinC.name = Coincount
        coinC.fontSize = 25
        coinC.text = String(format: "Jesus Points: %04u", 0)
        coinC.zPosition = 4
        
        coinC.position = CGPoint(
            x: screenWidth/3 * -1,
            y: screenHeight/3
        )
        addChild(coinC)
        
    }
    
    
    
    func addCoin(){
        let coin = SKSpriteNode(imageNamed: "gold_coin")
        coin.setScale(0.06)
        //collision detection
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.categoryBitMask = UInt32(obstacleCategory)
        coin.physicsBody?.isDynamic = true
        //coin.physicsBody?.contactTestBitMask = UInt32(playercategory)
        coin.physicsBody?.collisionBitMask = 1
        coin.physicsBody?.usesPreciseCollisionDetection = true
        coin.physicsBody?.affectedByGravity = false
        coin.zPosition = 2
        //coin.anchorPoint = CGPoint.zero
        coin.name = "coin"
        //random y position
        //let actualranY = random(min: coin.size.width, max:size.height-coin.size.height)
        let randomint = Int.random(in: -200..<200)
        //let randomy: CGFloat = CGFloat(arc4random_uniform(UInt32(randomint)))
        coin.position = CGPoint(x: screenWidth, y: CGFloat(randomint))
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
        
        for index in 0...3{
            let bg = SKSpriteNode(imageNamed: "Back")
            bg.size = CGSize(width: screenWidth*2, height: screenHeight )
            bg.position = CGPoint(x: index * Int(bg.size.width), y: 0)
            //bg.anchorPoint = CGPoint(x:0.0, y:0.0)
            bg.zPosition = 0
            bg.name = "Back"
            self.addChild(bg)
        }
    }
    func moveBackground() {
        self.enumerateChildNodes(withName: "Back", using: {(node, stop) -> Void in
            if let bg = node as? SKSpriteNode{
                bg.position = CGPoint(x: bg.position.x - self.backgroundVelocity, y : bg.position.y)
                
                if bg.position.x  <= -bg.size.width {
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
            adjustScore(by: 1)
        }
        if(firstBody.categoryBitMask == UInt32(playercategory)) && (secondBody.categoryBitMask == UInt32(BorderCategory)){
            print("intersecting border")
          
        }
        
    }
    
    
    
    
    
    
    
    
    //help users tap
    func processUserTaps(forUpdate currentTime: CFTimeInterval){
        for tapCount in tapQueue{
            if tapCount == 1 {
                // jump func
                jump()
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
