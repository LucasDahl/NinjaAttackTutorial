//
//  GameViewController.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/12/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the scene
        let scene = GameScene(size: view.bounds.size)
        
        // Setup the skview
        let skView = view as! SKView
        
        // Shpws the FPS and node count
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Ignore other siblings
        skView.ignoresSiblingOrder = true
        
        // Set the scene scale mode
        scene.scaleMode = .resizeFill
        
        // Present the scene
        skView.presentScene(scene)
        
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
