//
//  Controller.swift
//  session1
//
//  Created by LuanNX on 11/12/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class Controller{
    let view:View
    var parent:SKNode!
    init(view:View){
        self.view=view
    }
    var size:CGSize{
        get {
            return self.view.size
        }
    }
    var witdth:CGFloat{
        get{
            return self.view.size.width
        }
    }
    var height:CGFloat{
        get{
            return self.view.size.height
        }
    }
    var position:CGPoint{
        get{
            return self.view.position
        }
    }
    func config(position: CGPoint, parent:SKNode){
        self.view.position=position
        self.parent=parent
        parent.addChild(self.view)
    }
   
}
