//
//  GameScene.swift
//  session1
//
//  Created by LuanNX on 11/5/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
import GameplayKit
import Darwin
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var playerHeath=3
    let playerController=PlayerController()
     var repeatAddEnemies : Timer!
    var repeatAddOtherEnemies : Timer!
    func addBackGround(){
        let background=SKSpriteNode(imageNamed: "background")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -1
        
        self.addChild(background)
        
    }
    func addScore(){
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 100, y: self.size.height - 60)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        score = 0
        self.addChild(scoreLabel)
    }
    override func didMove(to view: SKView) {
        //addButton()
        addScore()
        addBackGround()
        configPhysics()
        let playerPosition=CGPoint(x: self.size.width/2, y: playerController.height/2)
        playerController.config(position: playerPosition, parent: self)
        addEnemies()
        addOtherEnemies()
        repeatAddEnemies = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(addEnemies), userInfo: nil, repeats: true)
        repeatAddOtherEnemies = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(addOtherEnemies), userInfo: nil, repeats: true)
       
        
    }

    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & PLAYER_BULLET_MASK) != 0 && (secondBody.categoryBitMask & ENEMY_MASK) != 0 {
            
            explosion(player: firstBody.node as! SKSpriteNode , enemy: secondBody.node as! SKSpriteNode )
            
            
        }
        if(firstBody.categoryBitMask & PLAYER_MASK) != 0 && (secondBody.categoryBitMask & ENEMY_BULLET_MASK) != 0{
            let scene=GameOverScene(size: self.frame.size)
            if let view:SKView=self.view {
                view.presentScene(scene , transition: SKTransition.fade(withDuration: 0.1))
            }
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    func addNewScene(){
        let newScene=SKSpriteNode(imageNamed: "GameOver")
        newScene.anchorPoint=CGPoint(x: 0, y: 0)
        newScene.position=CGPoint(x:0,y:0)
        newScene.size=CGSize(width: self.size.width, height: self.size.height)
        self.removeAllActions()
        self.removeAllChildren()
        self.addChild(newScene)
    }
    func addEnemies(){
        let enemyController1=EnemyController(texture: ENEMY_TEXTURE1)
        let enemyController2=EnemyController(texture: ENEMY_TEXTURE2)
        let rd=random()

        enemyController1.config(position: CGPoint(x: self.size.width*CGFloat(rd.1),y: self.size.height ), parent: self)
        enemyController2.config(position: CGPoint(x: self.size.width*CGFloat(rd.0),y: self.size.height), parent: self)
      
    }
    func addOtherEnemies(){
        let otherEnemyController=OtherEnemyController(texture: LEFT_ENEMY_TEXTURE)
        otherEnemyController.config(position: CGPoint(x:0 , y: self.size.height), parent: self)
    }
    func random() -> (Double,Double){
        var rand1:Double=0
        var rand2:Double=0
        var rand3:Double=0
        var rand4:Double=0
        var r12:Double=0
        var r34:Double=0
        repeat{
         rand1=Double(Int(arc4random_uniform(10)+1))
         rand2=Double(Int(arc4random_uniform(10)+1))
         rand3=Double(Int(arc4random_uniform(10)+1))
         rand4=Double(Int(arc4random_uniform(10)+1))
         r12=rand1/rand2
         r34=rand3/rand4
        
        }while((r12-0.5)*(r34-0.5)>=0 ||  r12>1 || r34>1  )
        return (r12,r34)
    }
  

    func configPhysics(){
        self.physicsWorld.gravity=CGVector(dx:0,dy:0)
        self.physicsWorld.contactDelegate=self
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch=touches.first{
            let location=touch.location(in: self)
            let previousLocation=touch.previousLocation(in: self)
            let movementVector = CGVector(dx: location.x - previousLocation.x,
                                          dy: location.y - previousLocation.y)
           playerController.move(vector: movementVector)
        }
    }
    
    func  explosion(player:SKSpriteNode, enemy:SKSpriteNode) {
        
        let explosion = SKSpriteNode(imageNamed: "explosion-1")
        explosion.size=CGSize(width: 40, height: 40)
        explosion.position = enemy.position
        self.addChild(explosion)
        
        //self.run(SKAction.playSoundFileNamed("Explosion3", waitForCompletion: false))
        
        player.removeFromParent()
        enemy.removeFromParent()
        
        
        self.run(SKAction.wait(forDuration: 0.1)) {
            explosion.removeFromParent()
        }
        
        score += 1
        
        
    }


}
