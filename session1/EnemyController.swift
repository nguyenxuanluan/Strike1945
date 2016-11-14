//
//  EnemyController.swift
//  session1
//
//  Created by LuanNX on 11/12/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class EnemyController:Controller{
    let SPEED:CGFloat = 100
    let SHOOT_INTERVAL = 0.5
    init(texture:SKTexture){
        super.init(view: SKSpriteNode(texture: texture) )
        view.physicsBody=SKPhysicsBody(texture: texture, size: texture.size())
        view.physicsBody?.categoryBitMask=ENEMY_MASK
        view.physicsBody?.contactTestBitMask=PLAYER_BULLET_MASK
        view.physicsBody?.collisionBitMask=0
    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        configMove()
        configShoot()
        
        
    }
    func configMove(){
        let moveToBottom=SKAction.movetoBot(position: self.position, speed: SPEED)
        view.run(SKAction.sequence([moveToBottom,SKAction.removeFromParent()]))
    }
    func configShoot() {
        let shootAction=SKAction.run{
            let enemyBulletController = EnemyBulletController(texture:ENEMY_BULLET_TEXTURE)
            let startPosition=CGPoint(x: self.position.x, y: self.position.y - (self.height+enemyBulletController.height)/2)
            enemyBulletController.config(position: startPosition, parent: self.parent)
            
        }
        let shootWithDelayAction=SKAction.sequence([shootAction,SKAction.wait(forDuration: SHOOT_INTERVAL)])
        let shootForever=SKAction.repeatForever(shootWithDelayAction)
        view.run(shootForever)
        
    }
    
}
