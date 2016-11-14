//
//  PlayerController.swift
//  session1
//
//  Created by LuanNX on 11/10/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class PlayerBulletController: Controller{
    let SPEED:CGFloat = 500.0
    
    init(){
        super.init(view: SKSpriteNode(texture: PLAYER_BULLET_TEXTURE))
        view.name="player_bullet"
        
        view.physicsBody = SKPhysicsBody(texture: PLAYER_BULLET_TEXTURE, size: view.size)
        view.physicsBody?.categoryBitMask = PLAYER_BULLET_MASK
        view.physicsBody?.contactTestBitMask = ENEMY_MASK
        view.physicsBody?.collisionBitMask = 0
    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        let moveToTopAction=SKAction.moveToTop(position: position, rect: parent.frame, speed: SPEED)
        let moveAndRemove=SKAction.moveAndRemove(action: moveToTopAction)
        view.run(moveAndRemove)
    }
   // let view:SKSpriteNode = SKSpriteNode(imageNamed: "bullet")
//    init(){
//        view.name="player_bullet"
//        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
//        
//        view.physicsBody?.categoryBitMask = PLAYER_BULLET_MASK
//        view.physicsBody?.contactTestBitMask = ENEMY_MASK
//        view.physicsBody?.collisionBitMask = 0
//        
//    }
//    func config(position : CGPoint, parent: SKNode){
//        self.view.position=position
//        let moveToTopAction=SKAction.moveToTop(position: position, rect: parent.frame, speed: SPEED)
//        let moveAndRemove=SKAction.moveAndRemove(action: moveToTopAction)
//        view.run(moveAndRemove)
//        parent.addChild(self.view)//Gamescene.addChild(self.view)
//    }

    //constructor
//    init(position:CGPoint, parent:SKNode) {
//        //COnfigure properties
//        view.position = position
//        view.name = "player_bullet"
//        
//        //Physics
//        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
//        
//        view.physicsBody?.categoryBitMask = PLAYER_BULLET_MASK
//        view.physicsBody?.contactTestBitMask = ENEMY_MASK
//        view.physicsBody?.collisionBitMask = 0
//        
//        //Action
//        let moveToTopAction=SKAction.moveToTop(position: position, rect: parent.frame, speed: SPEED)
//        let moveAndRemove=SKAction.moveAndRemove(action: moveToTopAction)
//        view.run(moveAndRemove)
//        
//        //position.y -> top => distance/SPEED
//        
//        
//    }
    
 

    
}
