//
//  MenuScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/14/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene, ButtonDelegate {
    
    // Properties
    
    private var button = Button()
    
    override func didMove(to view: SKView) {
        
        // Set the color of the view
        backgroundColor = SKColor.white
        
        if let button = self.childNode(withName: "button") as? Button {
            self.button = button
            button.delegate = self
        }
        
        // Setup the button
        let playButton = Button(imageNamed: "play")
        playButton.name = "button2"
        playButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        playButton.delegate = self
        addChild(playButton)
        
        // Setup the label
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Play Ninja Rush?"
        label.fontColor = SKColor.black
        label.fontSize = 40
        label.position = CGPoint(x: size.width / 2, y: playButton.position.y + 50)
        addChild(label)
        
    }
    
    func buttonClicked(sender: Button) {
        
        // Setup the scene
        let scene = GameScene(size: view!.bounds.size)
        
        // Set the scene scale mode
        scene.scaleMode = .resizeFill
        
        // Present the scene
        self.view!.presentScene(scene)
        
    }
    
    // Make sure theres no retains cycles.
    deinit {
        print("Reclaming memory.")
    }
    
}

