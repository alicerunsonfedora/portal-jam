//
//  TestDoorElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/15/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class TestDoorElement: TestOutputElement {
    
    /**
     Opens the door to let entities pass through.
     
     This is achieved by dropping the physics body on the door node.
     */
    func openDoor() {
        self.elementNode.physicsBody = nil
    }
    
    /**
     Closes the door, preventing entities from passing through.
     
     This is achieved by assigning a brand-new physics body similar to a wall.
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
        
        if self.isActive() {
            openDoor()
        } else {
            closeDoor()
        }
    }
    
}
