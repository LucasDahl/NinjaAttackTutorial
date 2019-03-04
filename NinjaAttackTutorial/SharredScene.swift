//
//  SharredScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/19/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit

//===========
// MARK: Enum
//===========
enum SceneType: String {
    case Menu, Game
}

class SharredScene: SKScene {
    
    //===================
    // MARK: - Properties
    //===================
    
    //==============
    // MARK: Methods
    //==============
    
    func addMonster(sceneTransition: SceneType) {
        
        // TODO: needs to be refactored due to a retain cycle
        
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
        // MARK: Will most likely need to make this a weak property to avoid retain cycles
        let moveAction = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
        
        // Create the action to remove the monster after it is off the screen
        let moveDoneAction = SKAction.removeFromParent()
        
        // Run the the action for the monster - will use later once the method has a a switch or if statment
        let loseAction = SKAction.run() { [weak self] in
            guard let `self` = self else { return }
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
            self.safteyRemoveAllNodes()
        }
        
//        if SceneType == SceneType.Menu {
//            monster.run(SKAction.sequence([moveAction, moveDoneAction])) // This will be for the MenuScene
//        } else if SceneType == SceneType.Game {
//            monster.run(SKAction.sequence([moveAction, loseAction, moveDoneAction])) // This will be for the GameScene
//            // Setup ip the category bitmask for the monster - This cannot be applied to the menu screen(it freaks out)
//            monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size)
//            monster.physicsBody?.isDynamic = true
//            monster.physicsBody?.categoryBitMask = PhysicsCategory.monster
//            monster.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
//            monster.physicsBody?.collisionBitMask = PhysicsCategory.none
//
//        }
        
        // Switch on the scene typ to call the correct actions
        switch sceneTransition {
            
        case SceneType.Menu:
            monster.run(SKAction.sequence([moveAction, moveDoneAction])) // This will be for the MenuScene
        case SceneType.Game:
            monster.run(SKAction.sequence([moveAction, loseAction, moveDoneAction])) // This will be for the GameScene
            // Setup ip the category bitmask for the monster - This cannot be applied to the menu screen(it freaks out)
            monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size)
            monster.physicsBody?.isDynamic = true
            monster.physicsBody?.categoryBitMask = PhysicsCategory.monster
            monster.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
            monster.physicsBody?.collisionBitMask = PhysicsCategory.none
        }
        
    }
    
    
    
    
    
    func safteyRemoveAllNodes() {
        
        // Removes all nodes so there are no retain cycles.
        self.removeAllChildren()
        self.removeAllActions()
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    // This is how to setup the tile set programmaticlly
    func setupTileSet() {
        
        // Setup the tiles
        let bgTexture = SKTexture(imageNamed: "grass")
        let bgDefinition = SKTileDefinition(texture: bgTexture, size: bgTexture.size())
        let bgGroup = SKTileGroup(tileDefinition: bgDefinition)
        let tileSet = SKTileSet(tileGroups: [bgGroup])
        let bgNode = SKTileMapNode(tileSet: tileSet, columns: 15, rows: 15, tileSize: bgTexture.size())
        bgNode.position = CGPoint(x: view!.frame.size.width, y: view!.frame.size.height)
        bgNode.setScale(1)
        
        let tile = bgNode.tileSet.tileGroups.first(
            where: {$0.name == "grass"})
        
        // Loop through the columns to place the tile
        for column in 0...4 {
            for row in 0...4 {
                bgNode.setTileGroup(tile, forColumn: column, row: row)
            }
        }
        
        // Makesure there is a tile that can be found
        guard SKTileSet(named: "Tiles") != nil else {
            // Don't use the filename for named, use the tileset inside
            fatalError()
        }
        
        // Finish setting up the tiles
        let tileSize = tileSet.defaultTileSize // from image size
        let tileMap = SKTileMapNode(tileSet: tileSet, columns: 15, rows: 15, tileSize: tileSize)
        let tileGroup = tileSet.tileGroups.first
        tileMap.fill(with: tileGroup) // fill or set by column/row
        tileMap.setTileGroup(tileGroup, forColumn: 15, row: 15)
        self.addChild(tileMap)
        bgNode.fill(with: tile)
        addChild(bgNode)
        
    }
    
}

