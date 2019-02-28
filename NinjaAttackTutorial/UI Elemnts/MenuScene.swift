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
        // Will need to be refactored
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(createMonster), SKAction.wait(forDuration: 1.0)])))
        
    }
    
    
    //================
    // MARK: - Methods
    //================
    
    //TODO: fix the retain cycele
    // Creates a reatin cycle
    func createMonster() {
        addMonster(newScene: SceneType.menuScene)
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

