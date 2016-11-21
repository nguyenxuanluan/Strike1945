//
//  ControllerManager.swift
//  session1
//
//  Created by LuanNX on 11/19/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class ControllerManger {
    let SPAWN_TIME:Double=2
    static let instance = ControllerManger()
    private init(){
        
    }
    func config(parent : SKNode) -> Void{
        let spawnEnemy=SKAction.run {
            let enemyController=GreenEnemyConroller()
            enemyController.config(position: parent.frame.topMiddle, parent: parent)
        }
        let spawnEnemyWithDelay = SKAction.sequence([spawnEnemy,SKAction.wait(forDuration: SPAWN_TIME)])
        parent.run(SKAction.repeatForever(spawnEnemyWithDelay))
    }
}
extension CGRect{
    var topMiddle: CGPoint{
        get {
            return CGPoint(x: self.midX, y: self.height)
        }
    }
}
