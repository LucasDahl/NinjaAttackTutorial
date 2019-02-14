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
        
        let button2 = Button(imageNamed: "play")
        button2.name = "button2"
        button2.position = CGPoint(x: size.width / 2, y: size.height / 2)
        button2.delegate = self
        addChild(button2)
        
        // Add the label
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Play Ninja Rush?"
        label.fontColor = SKColor.black
        label.fontSize = 40
        label.position = CGPoint(x: size.width / 2, y: button2.position.y + 50)
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

