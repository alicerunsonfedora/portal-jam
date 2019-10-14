//
//  Player.swift
//  Portals in Cupertino
//
//  Created by Nodar Sotkilava on 10/14/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    let moveRight = SKAction.moveBy(x: 5, y: 0, duration: 0.5)
    let moveLeft = SKAction.moveBy(x: -5, y: 0, duration: 0.5)
    let moveUp = SKAction.moveBy(x: 0, y: 5, duration: 0.5)
    let moveDown = SKAction.moveBy(x: 0, y: -5, duration: 0.5)
}
