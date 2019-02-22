//
//  SharredScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/19/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit

class SharredScene: SKScene {
    
    
    //===================
    // MARK: - Properties
    //===================
    
    let monster = SKSpriteNode(imageNamed: "monster")
    
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

        //: TODO add more actions for different levels
        monster.run(SKAction.sequence([moveAction, loseAction, moveDoneAction]))
    
        
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