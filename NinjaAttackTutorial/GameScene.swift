//
//  GameScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/12/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit
import GameplayKit

// Vector Math helppers
func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Choose one of the touches to work with
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Setup initial location of the projectile
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        
        // Determine the offset location to the projectile
        let offset = touchLocation - projectile.position
        
        // Bail out if you are shooting down or backwards
        if offset.x < 0 { return }
        
        // Add the projectile if its not down or backwards
        addChild(projectile)
        
        // Get the direction of where to shoot
        let direction = offset.normalized()
        
        // Make sure that the projectile goes far enough its off screen
        let shootAmount = direction * 1000
        
        // Add the shoot amount to the current position
        let realDest = shootAmount + projectile.position
        
        // Create the actions
        let moveAction = SKAction.move(to: realDest, duration: 2.0)
        let moveDoneAction = SKAction.removeFromParent()
        
        // Run the actions
        projectile.run(SKAction.sequence([moveAction, moveDoneAction]))
        
    }
  
}
