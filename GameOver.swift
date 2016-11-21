//
//  GameOver.swift
//  session1
//
//  Created by LuanNX on 11/16/16.
//  Copyright © 2016 LuanNX. All rights reserved.
//

import SpriteKit
class GameOverScene: SKScene{
    let SIDE_PLAY_AGAIN:CGFloat=70
    let playAgain=SKLabelNode(text: "PLAY AGAIN")
    let soundExlosion=SKAction.playSoundFileNamed("goSound", waitForCompletion: false)
    func addBackGround(){
        let background = SKSpriteNode(imageNamed: "bg.jpg")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x:0,y:0)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        background.zPosition = -1
        self.addChild(background)
    }
    func addGameOverLabel(){
        let gameover=SKLabelNode(text: "Game Over")
        gameover.fontSize=30
        gameover.fontColor=SKColor.cyan
        gameover.fontName="AmericanTypewriter-Bold"
        gameover.position=CGPoint(x: self.size.width/2, y: self.size.height*3/4)
        self.addChild(gameover)
    }
    func addPlayAgainLabel(){
        playAgain.fontColor=SKColor.red
        playAgain.position=CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.addChild(playAgain)
    }
    override func didMove(to view: SKView) {
        addBackGround()
        addGameOverLabel()
        addPlayAgainLabel()
        self.run(soundExlosion)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            if (playAgain.contains(location)) {
                let scene=GameScene(size: (self.view?.frame.size)!)
                if let view:SKView=self.view {
                view.presentScene(scene , transition: SKTransition.fade(withDuration: 0.2))
                }
            }
        }
    }
}
