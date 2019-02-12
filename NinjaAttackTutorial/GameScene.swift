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
    
    override func didMove(to view: SKView) {
        
        // Set the background color of the scene
        backgroundColor = SKColor.white
        
        // Set the player position
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        // Add the player to the scene
        addChild(player)
        
    }
  
}
