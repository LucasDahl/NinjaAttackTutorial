//
//  GameOverScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/13/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, won: Bool) {
        super.init(size: size)
        
        // Set the background color
        backgroundColor = SKColor.white
        
        // Create the message
        let message = won ? "You Won!" : "You Lose :("
        
        // Create the label and set the properties
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
        
        // Run the action
        run(SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.run() { [weak self] in
                
                // transition to a new scene to reveal the message
                guard let `self` = self else { return }
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
