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
    
    /**
     Whether the player is currently carrying an item. Defaults to `false`.
     */
    var isCarrying: Bool = false
    
    /**
     The player's current health. Defaults to `100`.
     */
    var health: Int = 100
    
    /**
     The player's camera.
     */
    var camera: SKCameraNode?
    
    /**
     Whether the player is dead.
     */
    var isDead: Bool = false
    
    /**
     Determine if the player is close to an item.
     - Parameters:
        - node: The node to check for closeness
     - Returns: Boolean dictating whether the player is near an item
     */
    func isCloseTo(node: SKNode) -> Bool {
        let dx = pow((node.position.x - self.position.x), 2)
        let dy = pow((node.position.y - self.position.y), 2)
        let distance = sqrt(dx + dy)
        
        return distance <= 50
    }
    
    /**
     Determine if the player is facing an item.
     - Parameters:
        - node: The node to check for proximity
     - Returns: Boolean dictating whether the player is facing an item
     */
    func isFacing(node: SKNode) -> Bool {
        let dx = node.position.x - self.position.x
        let dy = node.position.y - self.position.y
        let theta = atan2f(Float(dy), Float(dx))
        
        return abs(CGFloat(theta) - self.zRotation) < 10
    }
    
    /**
     Check the current health status and apply any necessary actions
     */
    func checkHealthStatus() {
        // Check if the player is dead
        if self.health == 0 {
            if !self.isDead {
                self.camera?.run(SKAction.scaleX(to: 0.3, y: 0.3, duration: 0.1))
                self.run(SKAction.colorize(with: NSColor.red, colorBlendFactor: 0.9, duration: 0.1))
                self.isDead = true
            }
        }
    }
    
    /**
     Initialize the player.
     - Parameters:
        - texture: The appropriate player texture.
        - camera: The player's respective camera
     */
    init(texture: SKTexture?, camera: SKCameraNode?) {
        
        self.camera = camera
        
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
    
    /**
        Move the player in a given direction
        - Parameters:
            - direction: x, y direction to move the player to
     */
    
    func moveTo(direction: CGPoint){
        if !self.isDead {
            self.run(SKAction.move(to: direction, duration: 0.1))
        }
    }
    
    /**
     Picks up the closest item in their vincinity.
     */
    func grabItem() {
        //Checks the relative TestWeightedStorageCubeElements and "picks" one up
        let weightedNodes = self.parent?.children.filter({ $0 is TestWeightedStorageCubeElement }).map({ node in node as! TestWeightedStorageCubeElement })
        
        if weightedNodes != nil{
            let anyWeightedNodesInContact = weightedNodes!.filter({ node in node.weighted && self.frame.contains(node.position) })
            if anyWeightedNodesInContact.count > 0 {
                anyWeightedNodesInContact[0].move(toParent: self)
                anyWeightedNodesInContact[0].zRotation = self.zRotation
                self.isCarrying = true
            }
    
            }
    }
    
    /**
     Drops an item the player is carrying, if there is one.
     */
    func dropItem() {
        //Checks if contains any TestWeightedStorageCubElement and "drops" it
        let weightedNodes = self.children.filter({ $0 is TestWeightedStorageCubeElement }).map({ node in node as! TestWeightedStorageCubeElement })
        
        if weightedNodes.count > 0{
            weightedNodes[0].move(toParent: self.parent!)
            self.isCarrying = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
