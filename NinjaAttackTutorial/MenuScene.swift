//
//  MenuScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/14/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var playButton = SKSpriteNode()
    let playButtonTex = SKTexture(imageNamed: "play")
    
    override func didMove(to view: SKView?) {
        backgroundColor = SKColor.lightGray
        
        
        playButton = SKSpriteNode(texture: playButtonTex)
        playButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        self.addChild(playButton)
        
        
        func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
            
            
            if let touch = touches.first as? UITouch {
                let pos = touch.location(in: self)
                let node = self.atPoint(pos)
                
                if node == playButton {
                    if let view = view {
                        
                        // Setup the scene
                        let scene = GameScene(size: view.bounds.size)
                        
                        // Set the scene scale mode
                        scene.scaleMode = .resizeFill
                        
                        // Present the scene
                        view.presentScene(scene)
                        
                    }
                }
            }
        }
    }
}
