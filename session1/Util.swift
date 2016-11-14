//
//  Util.swift
//  session1
//
//  Created by LuanNX on 11/10/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import Foundation
import SpriteKit
extension CGPoint{
    func add(other:CGPoint) -> CGPoint{
        return CGPoint(x: self.x + other.x, y: self.y+other.y)
    }
    func add(x:CGFloat, y:CGFloat) -> CGPoint{
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    func add(vector:CGVector) -> CGPoint{
        return CGPoint(x: self.x+vector.dx, y: self.y+vector.dy)
    }
    func distance(other:CGPoint) -> CGFloat{
        let dx=self.x-other.x
        let dy=self.y-other.y
        return sqrt(dx*dx + dy*dy)
    }
 
}
extension SKAction {
      static func moveToTop(position:CGPoint, rect: CGRect , speed:CGFloat) -> SKAction{
        let distance=rect.height - position.y
        let time=Double(distance/speed)
        return SKAction.moveTo(y: rect.height, duration: time)
    }
    
     static func movetoBot(position:CGPoint, speed: CGFloat) -> SKAction{
        let distance=position.y
        let time=distance/speed
        return SKAction.moveTo(y: 0, duration: Double(time))
    }
    static func moveAndRemove(action: SKAction) ->SKAction{
        return SKAction.sequence([action,SKAction.removeFromParent()])
    }
    static func moveToRight(position: CGPoint,rect: CGRect,speed: CGFloat) -> SKAction{
        let dx=rect.width
        let dy=position.y
        let distance = sqrt(dx*dx+dy*dy)
        let time=distance/speed
        return SKAction.move(to: CGPoint(x:rect.width,y:0), duration: Double(time))
    }
}
