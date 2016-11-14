//
//  OtherEnemyController.swift
//  session1
//
//  Created by LuanNX on 11/14/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class OtherEnemyController : EnemyController{
    override func configMove() {
        let moveToRight=SKAction.moveToRight(position: self.view.position, rect: parent.frame, speed: SPEED)
        view.run(SKAction.sequence([moveToRight,SKAction.removeFromParent()]))
    }
    override func configShoot() {
        let TIME_INTERVAL:Double=0.6
        let shootAction=SKAction.run{
           let otherEnemyBulletControler=OtherEnemyBulletController(texture: LEFT_ENEMY_BULLET_TEXTURE )
            let x:CGFloat=self.view.position.x + 20
            let y:CGFloat=self.view.position.y - 20
            let startPoint=CGPoint(x: x, y: y)
            otherEnemyBulletControler.config(position: startPoint, parent: self.parent)
        }
        let shootWithDelayAction=SKAction.sequence([shootAction,SKAction.wait(forDuration: TIME_INTERVAL)])
        view.run(SKAction.repeatForever(shootWithDelayAction))
    }
    
    
   
}
