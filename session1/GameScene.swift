//
//  GameScene.swift
//  session1
//
//  Created by LuanNX on 11/5/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let PLAYER_MOVE_SPEED = 500.0
    let ENEMY_SPEED = 200.0
    let player=SKSpriteNode(imageNamed: "plane3")
    let enemy=SKSpriteNode(imageNamed: "enemy_plane_white_1")

    let PLAYER_BULLET_SPEED = 500.0
    let ENEMY_BULLET_SPEED = 300.0
    let DELAY_TIME=0.5
    

    override func didMove(to view: SKView) {
        addBackGround()
        addPlayer()
        let point1=CGPoint(x: self.size.width/4, y: self.size.height-enemy.size.height/2)
        let point2=CGPoint(x: 3*self.size.width/4, y: self.size.height-enemy.size.height/2)
        
        let enemy1 = getEnemy(point: point1)
        let enemy2 = getEnemy(point: point2)
        repeatEnemyForever(enemy: enemy1,point: point1)
        repeatEnemyForever(enemy: enemy2,point: point2)
    }

    
        
    
    func getPlayerBullet() -> SKSpriteNode{
        return  SKSpriteNode(imageNamed: "bullet")
    }
    func getEnemy(point:CGPoint) -> SKSpriteNode{
        let  enemy=SKSpriteNode(imageNamed: "enemy_plane_white_1")
        enemy.anchorPoint=CGPoint(x:0.5,y:0.5)
        enemy.position=CGPoint(x: point.x, y: point.y)
        return enemy
        

    }
    
 
 
    func addEnemyBullet(ene:SKSpriteNode){
        let eBullet=SKSpriteNode(imageNamed: "enemy_bullet")
        eBullet.position=CGPoint(x: ene.position.x, y: ene.position.y - ( ene.size.height/2 + eBullet.size.height/2))
        let movetoBot=SKAction.moveTo(y: 0, duration: Double(eBullet.position.y)/ENEMY_BULLET_SPEED)
        let moveAndRemove=SKAction.sequence([movetoBot,SKAction.removeFromParent()])
        eBullet.run(moveAndRemove)
        self.addChild(eBullet)
    }
    func addEnemy(enemy:SKSpriteNode){
        
        let movetoBot=SKAction.moveTo(y: 0, duration: Double(enemy.position.y)/ENEMY_SPEED)
        let enemyShoot=SKAction.run {
            self.addEnemyBullet(ene: enemy)
        }
        let enemyShootWithDelay=SKAction.sequence([enemyShoot,SKAction.wait(forDuration: 0.7)])
        let enemyShootForever=SKAction.repeatForever(enemyShootWithDelay)
        let enemyMoveAndRemove=SKAction.sequence([movetoBot,SKAction.removeFromParent()])
        let moveShootAndRemove=SKAction.group([enemyShootForever,enemyMoveAndRemove])
        enemy.run(moveShootAndRemove)
        self.addChild(enemy)
    }

    func repeatEnemyForever(enemy:SKSpriteNode,point: CGPoint){
        let addenemy=SKAction.run{
            let enemy=self.getEnemy(point: point)
            self.addEnemy(enemy: enemy)
        }
        let enemyAppear=SKAction.sequence([addenemy,SKAction.wait(forDuration: 3)])
        let repeatForever=SKAction.repeatForever(enemyAppear)
        self.run(repeatForever)
    }
    
    func addPlayerBullet(){
        let pbullet=getPlayerBullet()
        pbullet.anchorPoint=CGPoint(x: 0.5, y: 0.5)
        pbullet.position = CGPoint(x: player.position.x, y: player.position.y + (pbullet.size.height/2 + player.size.height/2))
        let moveToRoof=SKAction.moveTo( y: self.size.height, duration: Double(self.size.height-pbullet.position.y) / PLAYER_BULLET_SPEED)
        let moveAndRemove=SKAction.sequence([moveToRoof,SKAction.removeFromParent()])
        pbullet.run(moveAndRemove)
        self.addChild(pbullet)
    }
    func addPlayer(){
        
        player.anchorPoint=CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: self.size.width/2, y: player.size.height/2)
        

        let shootAction=SKAction.run(addPlayerBullet)
        let shootActionWithDelay=SKAction.sequence([shootAction,SKAction.wait(forDuration: 0.2)])
        let shootActionForever=SKAction.repeatForever(shootActionWithDelay)
        
        player.run(shootActionForever)
        self.addChild(player)
        let rangeX = SKRange(lowerLimit: 0, upperLimit: self.size.width)
        let rangeY = SKRange(lowerLimit: 0, upperLimit: self.size.height - player.size.height/2 - getPlayerBullet().size.height/2)
        let constraint = SKConstraint.positionX(rangeX, y: rangeY)
        
        player.constraints = [constraint]

    }
    func addBackGround(){
        let background=SKSpriteNode(imageNamed: "background")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        self.addChild(background)

    }
 
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch=touches.first{
            
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            let touchVector = CGVector(dx: location.x-previousLocation.x,
                                       dy: location.y-previousLocation.y)
            
//            let limit=limitsize(touchVector: touchVector)
//            let limitWidth=limit.limitWidth
//            let limitHeight=limit.limitHeight
//         
//            print("5.limit ",limitWidth,",",limitHeight)
//            if abs(touchVector.dx) > limitWidth {
//                touchVector.dy=touchVector.dy*abs(limitWidth/touchVector.dx)
//                touchVector.dx=limitWidth
//                print( "after:",touchVector.dx,",", touchVector.dy)
//                print(" executed1")
//            }
//            if abs(touchVector.dy) > limitHeight {
//                touchVector.dx=touchVector.dx*abs(limitHeight/touchVector.dy)
//                touchVector.dy=limitHeight
//                print( "after:",touchVector.dx,",", touchVector.dy)
//                print(" executed2")
//            }
//            print("6.Final Vector:",touchVector)
            let time=sqrt(touchVector.dx*touchVector.dx + touchVector.dy*touchVector.dy)
            let move = SKAction.move(by: touchVector, duration: Double(time)/PLAYER_MOVE_SPEED)
            player.run(move)
        }

    }
//    func limitsize( touchVector:CGVector) -> ( limitWidth:CGFloat, limitHeight:CGFloat ){
//        var limitWidth:CGFloat = 0.0
//        var limitHeight:CGFloat = 0.0
//        if touchVector.dx >= 0 {
//            limitWidth = self.size.width -  player.position.x - abs(touchVector.dx)
//            if touchVector.dy >= 0 {
//                limitHeight =  self.size.height - player.position.y - touchVector.dy
//            } else {
//                limitHeight = player.position.y + touchVector.dy
//            }
//            
//        } else {
//            
//            limitWidth = player.position.x - abs(touchVector.dx)
//            if touchVector.dy >= 0 {
//                limitHeight=self.size.height -  player.position.y - abs(touchVector.dy)
//            } else {
//                limitHeight=player.position.y - abs(touchVector.dy)
//            }
//        }
//        return (limitWidth,limitHeight)
//
//    }
    

}
