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
    
    init(angle: CGFloat){
        super.init(view: View(texture: PLAYER_BULLET_TEXTURE))
        view.name="player_bullet"
        
        view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        view.physicsBody?.categoryBitMask = PLAYER_BULLET_MASK
        view.physicsBody?.contactTestBitMask = ENEMY_MASK
        view.physicsBody?.collisionBitMask = 0
        let rAngle = CGFloat (GLKMathDegreesToRadians(Float(angle)))
        let vector=CGVector(dx: SPEED*sin(rAngle), dy: SPEED*cos(rAngle))
        view.physicsBody?.velocity = vector
        view.handleContact = {
            otherView in
            print("Player bullet contact with enemy")
            otherView.removeFromParent()
        }
        view.zRotation = -rAngle
    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
//        let moveToTopAction=SKAction.moveToTop(position: position, rect: parent.frame, speed: SPEED)
//        let moveAndRemove=SKAction.moveAndRemove(action: moveToTopAction)
//        view.run(moveAndRemove)
    }
    
}
