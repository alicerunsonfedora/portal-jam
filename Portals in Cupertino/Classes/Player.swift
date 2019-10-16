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
    
    //let moveRight = SKAction.moveBy(x: 5, y: 0, duration: 0.5)
    //let moveLeft = SKAction.moveBy(x: -5, y: 0, duration: 0.5)
    let moveUp = SKAction.moveBy(x: 0, y: 5, duration: 0)
    let moveDown = SKAction.moveBy(x: 0, y: -5, duration: 0)
    let rotateLeft = SKAction.rotate(byAngle:(.pi/4), duration: 0)
    let rotateRight = SKAction.rotate(byAngle: -(.pi/4), duration: 0)
    
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture:texture, color:color, size:size)
        self.physicsBody = SKPhysicsBody(texture:texture!, size:( texture?.size())!)
        self.physicsBody?.restitution = 0
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.friction = 0.2
        self.physicsBody?.linearDamping = 0.1
        self.physicsBody?.angularDamping = 0.1
        self.physicsBody?.mass = 50
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
