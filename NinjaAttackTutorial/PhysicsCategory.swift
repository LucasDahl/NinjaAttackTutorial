//
//  PhysicsCategory.swift
//  NinjaAttackTutorial
//
//  Created by Lucas Dahl on 2/12/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import Foundation


struct PhysicsCategory {
    
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let monster: UInt32 = 0b1
    static let projectile: UInt32 = 0b10
    
}
