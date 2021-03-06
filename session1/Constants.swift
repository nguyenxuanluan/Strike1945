//
//  Constants.swift
//  session1
//
//  Created by LuanNX on 11/10/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
let PLAYER_MASK        = UInt32( 1 << 0 )
let PLAYER_BULLET_MASK = UInt32( 1 << 1 )

let ENEMY_BULLET_MASK  = UInt32( 1 << 2 )
let ENEMY_MASK         = UInt32( 1 << 3 )
let GIFT_MASK          = UInt32( 1 << 4 )
let FRAME_MASK         = UInt32( 1 << 5 )
let HEALTH_MASK        = UInt32( 1 << 6 )
let PLAYER_BULLET_TEXTURE = SKTexture(imageNamed: "bullet")
let ENEMY_BULLET_TEXTURE = SKTexture(imageNamed: "enemy_bullet")
let PLAYER_TEXTURE = SKTexture(imageNamed: "plane3")
let ENEMY_TEXTURE1=SKTexture(imageNamed: "enemy_plane_white_1")
let ENEMY_TEXTURE2 = SKTexture(imageNamed: "enemy-green-3")
let LEFT_ENEMY_TEXTURE = SKTexture(imageNamed: "enemy-green-1")
let LEFT_ENEMY_BULLET_TEXTURE=SKTexture(imageNamed: "bullet-right")
let HEALTH_TEXTURE=SKTexture(imageNamed: "addHealth")
let HEALTH_PLANE_TEXTURE=SKTexture(imageNamed: "planeHealth")
let SHOOT_INTERVAL=0.2
let ENEMY_GREEN1 = SKTexture(imageNamed: "enemy-green-1")
let ENEMY_GREEN2 = SKTexture(imageNamed: "enemy-green-2")
let ENEMY_GREEN3 = SKTexture(imageNamed: "enemy-green-3")
let ENEMY_GREEN_TEXTURE=[ENEMY_GREEN1,ENEMY_GREEN2,ENEMY_GREEN3]


