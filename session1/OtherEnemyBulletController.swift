//
//  OtherEnemyBulletController.swift
//  session1
//
//  Created by LuanNX on 11/14/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class OtherEnemyBulletController: EnemyBulletController{
    override func config(position: CGPoint, parent: SKNode) {
        let BULLET_SPEED:CGFloat=300
        self.view.position=position
        self.parent=parent
        let moveToRight = SKAction.moveToRight(position: position, rect: parent.frame, speed: BULLET_SPEED)
        view.run(SKAction.sequence([moveToRight,SKAction.removeFromParent()]))
        parent.addChild(self.view)
        
    }
}
