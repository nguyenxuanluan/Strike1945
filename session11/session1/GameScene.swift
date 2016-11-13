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

class GameScene: SKScene, SKPhysicsContactDelegate{
    var playerHeath=100
    let playerController=PlayerController()
     var repeatAddEnemies : Timer!
    func addBackGround(){
        let background=SKSpriteNode(imageNamed: "background")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        self.addChild(background)
        
    }

    override func didMove(to view: SKView) {
        addBackGround()
        configPhysics()
        let playerPosition=CGPoint(x: self.size.width/2, y: playerController.height/2)
        playerController.config(position: playerPosition, parent: self)
        addEnemies()
        repeatAddEnemies = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(addEnemies), userInfo: nil, repeats: true)
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA=contact.bodyA.node
        let nodeB=contact.bodyB.node
        if ( contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)==( PLAYER_BULLET_MASK | ENEMY_MASK){
            nodeA?.removeFromParent()
            nodeB?.removeFromParent()
            
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (PLAYER_MASK|ENEMY_BULLET_MASK){
           
                addNewScene()
                repeatAddEnemies.invalidate()
            
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
   

}
