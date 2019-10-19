//
//  TestDeadlyElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/19/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Base class for deadly elements. Classes that inherit this class will be able to inflict damage on the player.
 */
class TestDeadlyElement {
    
    /**
     How much damage to give to the test subject.
     */
    var healthPenalty: Int
    
    /**
     The associated node for this element.
     */
    var elementNode: SKSpriteNode
    
    /**
     The player to give damage to.
     */
    var playerTarget: Player?
    
    /**
     Deliver damage to the player or kill them, whichever is more likely.
     
     If the player's health will result in a negative integer after subtracting damage, the player's health will automatically be set to `0`.
     */
    func deliverDamage() {
        if self.playerTarget != nil {
            if ((self.playerTarget?.health ?? 0) - healthPenalty < 0) {
                self.playerTarget?.health = 0
            } else {
                self.playerTarget?.health -= healthPenalty
            }
            self.playerTarget?.checkHealthStatus()
        }
    }
    
    /**
     Assign a player to watch over.
     
     This is often used during tilemap parsing when the player has been initialized after a deadly element. Use this function to assign the player afterwards.
     - Parameters:
        - to: The player to watch
     */
    func assignPlayer(to: Player?) {
        self.playerTarget = to
    }
    
    /**
     Initialize the deadly element.
     - Parameters:
        - damage: How much damage to give
        - node: The associated `SKSpriteNode`
        - player: The player to target
     */
    init(damage: Int, node: SKSpriteNode, player: Player?) {
        self.healthPenalty = damage
        self.elementNode = node
        self.playerTarget = player
    }
    
}
