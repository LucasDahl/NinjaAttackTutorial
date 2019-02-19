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
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(monsterBackground), SKAction.wait(forDuration: 1.0)])))
        
    }
    
    //================
    // MARK: - Methods
    //================
    // TODO: Add a clss for the monsters and the tile background to conform to the DRY principal
    // This conflicts with the DRY principal, need to refactor
    // TODO: ========================= Start refactor needed
    
    func monsterBackground() {
        
        // Create a monster Sprite
        let monster = SKSpriteNode(imageNamed: "monster")
        
        // Determine where to spawn the monster along the Y axis
        let actualY = random(min: monster.size.height / 2, max: size.height - monster.size.height / 2)
        
        // Position the monster slightly off-screen along the right edge, and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: size.width + monster.size.width / 2, y: actualY)
        
        // Add the monster to the scene
        addChild(monster)
        
        // Determine the speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions for the monster
        let moveAction = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
        
        // Create the action to remove the monster after it is off the screen
        let moveDoneAction = SKAction.removeFromParent()
        
        monster.run(SKAction.sequence([moveAction, moveDoneAction]))
        
    }
    
    // ====================== End refactor needed
    
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

