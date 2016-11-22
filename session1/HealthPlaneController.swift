//
//  HealthPlaneController.swift
//  session1
//
//  Created by LuanNX on 11/22/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class HealthPlaneController:Controller{
    let DIVISOR:CGFloat=10
    let SPEED:CGFloat=200
    init(){
        let size=CGSize(width: HEALTH_PLANE_TEXTURE.size().width/DIVISOR,
                        height: HEALTH_PLANE_TEXTURE.size().height/DIVISOR)
        super.init(view: View(texture: HEALTH_PLANE_TEXTURE))
        self.view.size=size
    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        configPhysics()
        configMove()
    }
    func configPhysics(){
    view.physicsBody=SKPhysicsBody(rectangleOf: view.size)
    view.physicsBody?.categoryBitMask=ENEMY_MASK
    view.physicsBody?.contactTestBitMask=PLAYER_BULLET_MASK
    view.physicsBody?.collisionBitMask=0
        view.handleContact = {
            otherView in
            let health=HealthController()
            health.config(position: self.view.position, parent: self.parent)
            self.view.removeFromParent()
            otherView.removeFromParent()
        }
    }
    func configMove(){
        let move=SKAction.moveTo(x: self.parent.frame.width, duration: Double(self.parent.frame.width/SPEED))
        let remove=SKAction.removeFromParent()
        self.view.run(SKAction.sequence([move,remove]))
    }
}
