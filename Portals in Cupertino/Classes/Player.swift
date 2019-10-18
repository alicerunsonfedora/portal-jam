//
//  Player.swift
//  Portals in Cupertino
//
//  Created by Nodar Sotkilava on 10/14/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 The primary test subject in a testchamber.
 
 The player is an inherited `TestWeightedElement`, allowing it to interact with buttons and other weight-based items. The player also handles collisions with walls and moves.
 */
class Player: TestWeightedElement {
    
    let moveUp = SKAction.moveBy(x: 0, y: 5, duration: 0)
    let moveDown = SKAction.moveBy(x: 0, y: -5, duration: 0)
    let rotateLeft = SKAction.rotate(byAngle:(.pi/4), duration: 0)
    let rotateRight = SKAction.rotate(byAngle: -(.pi/4), duration: 0)
    
    /**
     Initialize the player.
     - Parameters:
        - texture: The appropriate player texture.
     */
    init(texture: SKTexture?) {
        super.init(texture:texture, weighted: true)
        
        self.physicsBody = SKPhysicsBody(texture:texture!, size:( texture?.size())!)
        self.physicsBody?.restitution = 0
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.friction = 0.2
        self.physicsBody?.linearDamping = 0.1
        self.physicsBody?.angularDamping = 0.1
        self.physicsBody?.mass = 50
        
        self.zPosition = 5
    }
    
    func moveTo(direction: CGPoint){
        self.run(SKAction.move(to: direction, duration: 0.1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
