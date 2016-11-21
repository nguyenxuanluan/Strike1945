//
//  GreenEnemyController.swift
//  session1
//
//  Created by LuanNX on 11/19/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class GreenEnemyConroller:EnemyController{
    init(){
        super.init(texture: ENEMY_GREEN1)
    }
    override func config(position: CGPoint, parent: SKNode) {
        self.view.position=position
        self.parent=parent
        parent.addChild(self.view)
        let animated=SKAction.repeatForever(SKAction.animate(with: ENEMY_GREEN_TEXTURE, timePerFrame: 0.1))
        self.view.run(animated)
        self.view.run(SKAction.moveAndRemove(position: self.position, speed: SPEED))
        configShoot()
        self.view.handleContact = {
            otherView in
            print("Enemy contact with bullet")
            let giftController=GiftController()
            giftController.config(position: self.position, parent: self.parent)
            self.view.removeFromParent()
            otherView.removeFromParent()
        }
      
    }
   
}
