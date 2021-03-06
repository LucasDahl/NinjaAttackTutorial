//
//  Button.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/14/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import Foundation
import SpriteKit

// Protcol method
protocol ButtonDelegate: class {
    func buttonClicked(sender: Button)
}

class Button: SKSpriteNode {
    
    // Weak so that you don't create a strong circular reference with the parent
    weak var delegate: ButtonDelegate!
    
    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        
        // Call the setup method
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Call the setup method
        setup()
        
    }
    
    // Allows for user interaction
    func setup() {
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(0.9)
        self.delegate.buttonClicked(sender: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
} // End class
