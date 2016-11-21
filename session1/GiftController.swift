//
//  GiftController.swift
//  session1
//
//  Created by LuanNX on 11/19/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class GiftController: Controller {
    let SPEED:CGFloat=100
    init(){
        super.init(view: View(imageNamed: "power-up"))
       
    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        self.view.run(SKAction.moveAndRemove(position: position, speed: SPEED))
        configPhysics()
    }
    func configPhysics(){
        view.physicsBody=SKPhysicsBody(rectangleOf: view.size)
        view.physicsBody?.categoryBitMask=GIFT_MASK
        view.physicsBody?.contactTestBitMask=PLAYER_MASK
        view.physicsBody?.collisionBitMask=0
        self.view.handleContact = {
            otherView in
            otherView.handlePowerUp?()
      
        }
    }
}
