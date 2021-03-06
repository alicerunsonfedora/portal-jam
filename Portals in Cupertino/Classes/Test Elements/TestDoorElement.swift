//
//  TestDoorElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/15/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 A basic door controlled by an input.
 */
class TestDoorElement: TestOutputElement {
    
    /**
     Opens the door to let entities pass through.
     
     This is achieved by dropping the physics body on the door node. For visual effect, the opacity of the element is also lowered so that players can see that it is indeed open.
     */
    func openDoor() {
        if self.elementNode.physicsBody != nil {
            self.elementNode.physicsBody = nil
        }
        self.elementNode.run(SKAction.fadeAlpha(to: 0.7, duration: 0.25))
    }
    
    /**
     Closes the door, preventing entities from passing through.
     
     This is achieved by assigning a brand-new physics body similar to a wall. The opacity of the door is also changed back to 1.00.
     */
    func closeDoor() {
        self.elementNode.physicsBody = SKPhysicsBody(texture: self.elementNode.texture!,
                                                     size: CGSize(width: ((self.elementNode.texture?.size().width)!),
                                                                  height: ((self.elementNode.texture?.size().height)!)))
        self.elementNode.physicsBody?.restitution = 0
        self.elementNode.physicsBody?.isDynamic = false
        self.elementNode.physicsBody?.affectedByGravity = false
        self.elementNode.physicsBody?.linearDamping = 1000.0
        self.elementNode.physicsBody?.allowsRotation = false
        self.elementNode.physicsBody?.friction = 0.7
        
        self.elementNode.run(SKAction.fadeAlpha(to: 1.00, duration: 0.25))
    }
    
    /**
     Check the door's status and open/close appropriately.
     */
    func toggleDoor() {
        if self.isActive() {
            openDoor()
        } else {
            closeDoor()
        }
    }
    
    /**
     Initialize a door.
     - Parameters:
        - inputs: The inputs the door is connected to.
        - node: The door node.
        - isMetalWall: Whether the door is on a metal wall or not.
     */
    init(inputs: [TestInputElement], node: SKSpriteNode, isMetalWall: Bool) {
        var textureName = ""
        
        if isMetalWall {
            textureName = "Metal_Wall_With_Door"
        } else {
            textureName = "Concrete_Wall_with_Door"
        }
        
        super.init(inputs: inputs, node: node, textureName: textureName)
        
        self.toggleDoor()
        self.elementNode.zPosition = 6
        
    }
    
}
