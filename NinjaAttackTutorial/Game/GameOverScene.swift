//
//  GameOverScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/13/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene, ButtonDelegate {
    
    // Properties
    private var button = Button()
    
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
        label.position = CGPoint(x: size.width / 2, y: (size.height / 2) + 50)
        addChild(label)
        
        // Make sure there is a button
        if let button = self.childNode(withName: "button") as? Button {
            self.button = button
            button.delegate = self
        }
        
        // Setup the button
        let playButton = Button(imageNamed: "play")
        playButton.name = "button"
        playButton.position = CGPoint(x: label.position.x, y: label.position.y - 100)
        playButton.delegate = self
        addChild(playButton)
        
        // Setup the label
        let labelMessage = SKLabelNode(fontNamed: "Chalkduster")
        labelMessage.text = "Play Again?"
        labelMessage.fontColor = SKColor.black
        labelMessage.fontSize = 40
        labelMessage.position = CGPoint(x: size.width / 2, y: playButton.position.y + 50)
        addChild(labelMessage)
        
    }

        // Run the action (this takes out the ability to get to the main menu)
//        run(SKAction.sequence([
//            SKAction.wait(forDuration: 3.0),
//            SKAction.run() { [weak self] in
//
//                // transition to a new scene to reveal the message
//                guard let `self` = self else { return }
//                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
//                let scene = GameScene(size: size)
//                self.view?.presentScene(scene, transition:reveal)
//            }
//            ]))
    
    func buttonClicked(sender: Button) {
        // Setup the scene
        let scene = GameScene(size: view!.bounds.size)
        
        // Set the scene scale mode
        scene.scaleMode = .resizeFill
        
        // Present the scene
        self.view!.presentScene(scene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
