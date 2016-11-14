//
//  EnemyBulletController.swift
//  session1
//
//  Created by LuanNX on 11/12/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class EnemyBulletController:Controller{
    let SPEED:CGFloat=300.0
    init(){
        super.init(view: SKSpriteNode(texture: ENEMY_BULLET_TEXTURE))
        view.name="enemy_bullet"
        view.physicsBody=SKPhysicsBody(texture: ENEMY_BULLET_TEXTURE, size: view.size)
        view.physicsBody?.categoryBitMask=ENEMY_BULLET_MASK
        view.physicsBody?.contactTestBitMask=PLAYER_MASK
        view.physicsBody?.collisionBitMask=0
       

    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        let movetoBot=SKAction.movetoBot(position: position, speed: SPEED)
        let moveAndRemove=SKAction.sequence([movetoBot,SKAction.removeFromParent()])
        view.run(moveAndRemove)
    }

}
