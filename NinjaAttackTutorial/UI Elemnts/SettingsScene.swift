//
//  SettingsScene.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 4/5/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import SpriteKit

class SettingsScene: SharredScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = SKColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("reclaiming memory")
    }
    
}
