//
//  SharredScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/19/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit

class SharredScene: SKScene {
    
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
