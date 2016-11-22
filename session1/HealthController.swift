//
//  HealthController.swift
//  session1
//
//  Created by LuanNX on 11/22/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class HealthController:Controller {
    let SPEED:CGFloat=200
    let DIVISOR:CGFloat=5
    init() {
       
        super.init(view: View(texture: HEALTH_TEXTURE))
        let size=CGSize(width: self.view.size.width/DIVISOR, height: self.view.size.height/DIVISOR)
        self.view.size=size
    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        self.view.run(SKAction.moveAndRemove(position: position, speed: SPEED))
        configPhysics()
    }
    func configPhysics(){
        view.physicsBody=SKPhysicsBody(rectangleOf: self.view.size)
        view.physicsBody?.categoryBitMask=HEALTH_MASK
        view.physicsBody?.contactTestBitMask=PLAYER_MASK
        view.physicsBody?.collisionBitMask=0
        view.handleContact = {
            otherView in
            otherView.handleAddHealth?()
        }
    }
}
