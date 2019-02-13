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
    var monsterDestroyed = 0
    
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
        
        // Setup the physics - Needs to not have physics for this game
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // Sound effects
        let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
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
        
        // Setup ip the category bitmask for the monster
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size)
        monster.physicsBody?.isDynamic = true
        monster.physicsBody?.categoryBitMask = PhysicsCategory.monster
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
        monster.physicsBody?.collisionBitMask = PhysicsCategory.none
        
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
        let loseAction = SKAction.run() { [weak self] in
            guard let `self` = self else { return }
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        
        monster.run(SKAction.sequence([moveAction, loseAction, moveDoneAction]))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Choose one of the touches to work with
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Play the sound effect for projectiles
        run(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        
        // Setup initial location of the projectile
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        
         // Setup ip the category bitmask for the monster
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width / 2)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        
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
    
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: SKSpriteNode) {
        
        print("hit")
        // Remove both the monster and the projectile once the contact each other
        projectile.removeFromParent()
        monster.removeFromParent()
        
        // Add one to the number of monsters destroyed for each hit
        monsterDestroyed += 1
        
        if monsterDestroyed > 30 {
            
            // Once the player gets to 30 flip the scene to the GameOverScene
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            
            // Reveal the scene
            let gameOverScene = GameOverScene(size: self.size, won: true)
            view?.presentScene(gameOverScene, transition: reveal)
            
        }
        
        
        
    }
  
} // End class

//==================
// MARK: - Extension
//==================

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // Properties
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // This is for testing collisions and since they are not passed in any particular order they need to be sorted
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.monster != 0) && (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
            if let monster = firstBody.node as? SKSpriteNode, let projectile = secondBody.node as? SKSpriteNode {
                projectileDidCollideWithMonster(projectile: projectile, monster: monster)
            }
        }
    }
} // End extension
