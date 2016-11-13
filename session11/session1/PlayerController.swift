//
//  PlayerController.swift
//  session1
//
//  Created by LuanNX on 11/12/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class PlayerController:Controller{

    init(){
        //set view
      super.init(view: SKSpriteNode(texture: PLAYER_TEXTURE))
        view.physicsBody=SKPhysicsBody(texture: PLAYER_TEXTURE, size:PLAYER_TEXTURE.size() )
        view.physicsBody?.categoryBitMask=PLAYER_MASK
        view.physicsBody?.contactTestBitMask=ENEMY_BULLET_MASK
        view.physicsBody?.collisionBitMask=0
        
        
    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        configShoot()
        configConstrains()
       
    }
    func move(vector:CGVector){
        view.position=view.position.add(vector: vector)
        
    }
    func configShoot(){
        let shootAction=SKAction.run {
         let   bulletController=PlayerBulletController()
            let startPosition=CGPoint(x: self.position.x, y: self.position.y + 0.5*(self.height + bulletController.height))
            bulletController.config(position: startPosition, parent: self.parent)
        }
        let shootWithDelay=SKAction.sequence([shootAction,SKAction.wait(forDuration: SHOOT_INTERVAL)])
        view.run(SKAction.repeatForever(shootWithDelay))
    }
    func configConstrains(){
        let xRange = SKRange(lowerLimit: 0, upperLimit: parent.frame.width)
        let yRange = SKRange(lowerLimit: 0, upperLimit: parent.frame.height)
        view.constraints = [SKConstraint.positionX(xRange, y: yRange)]
    }
    
}
