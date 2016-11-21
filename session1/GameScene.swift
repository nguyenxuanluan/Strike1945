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
    var hpLabel:SKLabelNode!
     var hp = 10 {
        didSet {
            hpLabel.text = "HP: \(hp)"
        }
    }
  
    let playerController=PlayerController.instance
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
    func addHp() {
        hpLabel = SKLabelNode(text: "HP: 10")
        hpLabel.position=CGPoint(x: 45, y: 10)
        hpLabel.fontName="AmericanTypewriter-Bold"
        hpLabel.fontSize=20
        hpLabel.fontColor=UIColor.green
        self.addChild(hpLabel)
    }
    func physhics(){
        let frame=SKSpriteNode(imageNamed: "background")
        frame.anchorPoint = CGPoint(x: 0, y: 0)
        frame.position = CGPoint(x: 0, y: 0)
        frame.physicsBody=SKPhysicsBody(rectangleOf: frame.size)
        frame.physicsBody?.categoryBitMask=FRAME_MASK
        frame.physicsBody?.contactTestBitMask=ENEMY_BULLET_MASK
        frame.physicsBody?.collisionBitMask=0

    }
    override func didMove(to view: SKView) {
        addScore()
        addHp()
        addBackGround()
        configPhysics()
        ControllerManger.instance.config(parent: self)
        
        let playerPosition=CGPoint(x: self.size.width/2, y: playerController.height/2)
        playerController.config(position: playerPosition, parent: self)
        physhics()
        //addEnemies()
        //addOtherEnemies()
        repeatAddEnemies = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(addEnemies), userInfo: nil, repeats: true)
        repeatAddOtherEnemies = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(addOtherEnemies), userInfo: nil, repeats: true)
       
        
    }

    func didBegin(_ contact: SKPhysicsContact) {
        guard let viewA=contact.bodyA.node as? View,
        let viewB=contact.bodyB.node as? View
            else{
                return
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
            == (PLAYER_MASK | ENEMY_BULLET_MASK){
            hp-=1
                    }
        viewA.handleContact?(viewB)
        viewB.handleContact?(viewA)
        if hp==0 {
            self.run(SKAction.sequence([SKAction.wait(forDuration: 3),SKAction.run(newScene)]))
        }
        score+=1
    }
    func didEnd(_ contact: SKPhysicsContact) {
        
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
    func newScene(){
        let scene = GameOverScene(size: self.size)

        if let otherView:SKView=self.view {
            otherView.presentScene(scene)
        }
        
    }
    


}
