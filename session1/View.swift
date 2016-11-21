//
//  View.swift
//  session1
//
//  Created by LuanNX on 11/17/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//


import SpriteKit

typealias HandleContactType = (View) -> ()
typealias HandlePowerUp = () -> ()

class View : SKSpriteNode {
    var handleContact: HandleContactType?
    var handlePowerUp: HandlePowerUp?
}
