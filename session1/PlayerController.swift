//
//  PlayerController.swift
//  session1
//
//  Created by LuanNX on 11/12/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class PlayerController:Controller{
    static let  instance = PlayerController()
    var hp=10
    let SHOOT_ACTION_KEY="shootAction"
    var shootAction: SKAction?
    let playerExplosion=SKSpriteNode(imageNamed: "playerExplosion")
    let playerES=SKAction.playSoundFileNamed("playerExplosionSound", waitForCompletion: false)
    let eatSound=SKAction.playSoundFileNamed("eat", waitForCompletion: false)
    private init(){
        //set view
      super.init(view: View(texture: PLAYER_TEXTURE))
        
    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        configConstrains()
        playSound()
        configPhysics()
        configShoot(powerUp: false)
       
    }
    func configPhysics(){
        self.view.physicsBody=SKPhysicsBody(rectangleOf: self.view.size)
        self.view.physicsBody?.categoryBitMask=PLAYER_MASK
        self.view.physicsBody?.contactTestBitMask = GIFT_MASK | ENEMY_BULLET_MASK
        self.view.physicsBody?.collisionBitMask=0
        self.view.handleContact = {
            otherView in
            if ( ENEMY_BULLET_MASK & (otherView.physicsBody?.categoryBitMask)! ) != 0{
                otherView.removeFromParent()
                self.hp-=1;
                print("this is enemy bullet")
            }
            else {
                otherView.removeFromParent()
                self.view.run(SKAction.playSoundFileNamed("Powerup", waitForCompletion: false))
            }
            if self.hp==0 {
                self.view.removeFromParent()
                self.explosion()
                self.hp=10
            }
        }
        self.view.handlePowerUp = {
            print("Handle power up")
            self.configShoot(powerUp: true)
        }
        self.view.handleAddHealth = {
            self.parent.run(self.eatSound)
            self.hp=10;
        }
    }
    func move(vector:CGVector){
        view.position=view.position.add(vector: vector)
        
    }
    func playSound(){
        let playSound=SKAction.playSoundFileNamed("Laser_Shoot4", waitForCompletion: false)
        let playSoundwithDelay=SKAction.sequence([playSound,SKAction.wait(forDuration: SHOOT_INTERVAL)])
        let repeatPlaySound=SKAction.repeatForever(playSoundwithDelay)
        view.run(repeatPlaySound)
    }
    
    func configShoot(powerUp: Bool) {
        
        //view.removeAction(forKey: SHOOT_ACTION_KEY)
        
        if powerUp {
            shootAction = SKAction.run {
                let bulletController = PlayerBulletController(angle: 0)
                let bulletController1 = PlayerBulletController(angle: 30)
                let bulletController2 = PlayerBulletController(angle: -30)
                
                let startPosition = CGPoint(x: self.position.x, y: self.position.y + 0.5 * (self.height + bulletController.height))
                
                bulletController.config(position: startPosition, parent: self.parent)
                bulletController1.config(position: startPosition, parent: self.parent)
                bulletController2.config(position: startPosition, parent: self.parent)
            }
        }
        else {
            shootAction = SKAction.run {
                let bulletController = PlayerBulletController(angle: 0)
                
                let startPosition = CGPoint(x: self.position.x, y: self.position.y + 0.5 * (self.height + bulletController.height))
                
                bulletController.config(position: startPosition, parent: self.parent)
            }
        }
        
        let shootWithDelayAction = SKAction
            .sequence([shootAction!, SKAction.wait(forDuration: SHOOT_INTERVAL)])
        
        view.run(SKAction.repeatForever(shootWithDelayAction), withKey: SHOOT_ACTION_KEY)
    }
    func configConstrains(){
        let xRange = SKRange(lowerLimit: 0, upperLimit: parent.frame.width)
        let yRange = SKRange(lowerLimit: 0, upperLimit: parent.frame.height)
        view.constraints = [SKConstraint.positionX(xRange, y: yRange)]
    }
    func explosion(){
        playerExplosion.position=self.view.position
        playerExplosion.size=CGSize(width: 60, height: 30)
        parent.run(playerES)
        parent.addChild(playerExplosion)
        let remove=SKAction.run {
            self.playerExplosion.removeFromParent()
        }
        
        parent.run(SKAction.sequence([SKAction.wait(forDuration: 1),remove]))
    }
   
    
}
