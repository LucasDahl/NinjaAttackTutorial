//
//  MenuScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/14/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit

class MenuScene: SharredScene, ButtonDelegate {
    
    //===================
    // MARK: - Properties
    //===================
    
    private var button = Button()
    
    //=========================
    // MARK: - Override Methods
    //=========================
    
    override func didMove(to view: SKView) {
        
        // Setup tiles
        //backgroundColor = SKColor.white
        setupTileSet()
        
        if let button = self.childNode(withName: "button") as? Button {
            self.button = button
            button.delegate = self
        }
        
        // Setup the button
        let playButton = Button(imageNamed: "play")
        playButton.name = "button2"
        playButton.position = CGPoint(x: (size.width / 2) - 30, y: size.height / 2)
        playButton.delegate = self
        addChild(playButton)
        
        // Setup the label
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Play Ninja Rush?"
        label.fontColor = SKColor.black
        label.fontSize = 40
        label.position = CGPoint(x: size.width / 2, y: playButton.position.y + 50)
        label.zPosition = 10
        addChild(label)
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(monsterSetup), SKAction.wait(forDuration: 1.0)])))
        
        // Difficulty button
        let diffButton = Button(imageNamed: "diff")
        diffButton.name = "button3"
        diffButton.position = CGPoint(x: (size.width / 2) + 30, y: size.height / 2)
        diffButton.delegate = self
        addChild(diffButton)
        
    }
    
    //================
    // MARK: - Methods
    //================
    
    func monsterSetup() {
        addMonster(sceneTransition: SceneType.Menu)
    }
    
    // TODO: Add a way to switch between scenes based on what button was pressed
    func buttonClicked(sender: Button) {
        
        // Setup the scene
        let scene = GameScene(size: view!.bounds.size)
        
        // Removes all nodes so there are no retain cycles.
        safteyRemoveAllNodes()
        
        // Set the scene scale mode
        scene.scaleMode = .resizeFill
        
        // Present the scene
        self.view!.presentScene(scene)
        
        
        
    }
    
    // Make sure theres no retains cycles.
    deinit {
        print("Reclaming memory")
    }
    
}// End class

