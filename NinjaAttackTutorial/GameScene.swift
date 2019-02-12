//
//  GameScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/12/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //===================
    // MARK: - Properties
    //===================
    
    let player = SKSpriteNode(imageNamed: "player")
    
    //=========================
    // MARK: - didMove
    //=========================
    
    override func didMove(to view: SKView) {
        
        // Set the background color of the scene
        backgroundColor = SKColor.white
        
        // Set the player position
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        // Add the player to the scene
        addChild(player)
        
        // Add a new monster every second
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addMonster), SKAction.wait(forDuration: 1.0)])))
        
    }
    
    //================
    // MARK: - Methods
    //================
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        
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
        
        // Run the the action for the monster
        monster.run(SKAction.sequence([moveAction, moveDoneAction]))
        
    }
  
}
