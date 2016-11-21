//
//  EnemyBulletController.swift
//  session1
//
//  Created by LuanNX on 11/12/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class EnemyBulletController:Controller{
    let SPEED:CGFloat=200.0
    init(texture : SKTexture){
        super.init(view: View(texture: texture))
        view.name="enemy_bullet"
        view.physicsBody=SKPhysicsBody(rectangleOf: self.view.size)
        view.physicsBody?.categoryBitMask=ENEMY_BULLET_MASK
        view.physicsBody?.contactTestBitMask=PLAYER_MASK | FRAME_MASK
        view.physicsBody?.collisionBitMask=0
        self.view.handleContact = {
            otherView in
            if ((otherView.physicsBody?.categoryBitMask)! & FRAME_MASK) != 0{
                print("Remove from frame") 
            }
            self.view.removeFromParent()
           
        }
       

    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        let dest=PlayerController.instance.position
        let distance = dest.distance(other: self.position)
        let velocity=dest.substract(other: self.position).divide(ratio: (distance/SPEED))
        self.view.physicsBody?.velocity=velocity
        
    }

}
