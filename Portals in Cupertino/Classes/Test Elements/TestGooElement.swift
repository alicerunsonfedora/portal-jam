//
//  TestGooElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/19/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Deadly goo as a test element.
 
 Deadly goo adds an extra challenge to test chambers as players should die on contact. This is often used to seperate parts of the testchamber and add an extra level of complexity.
 */
class TestGooElement: TestDeadlyElement {
    
    /**
     Watch for if the player enters the goo and deliver damage when ready.
     */
    func scanForDamage() {
        if self.playerTarget != nil {
            if self.elementNode.frame.contains((self.playerTarget?.position)!) {
                self.deliverDamage()
            }
        }
    }
    
    /**
     Initialize the deadly goo.
     - Parameters:
        - node: The associated `SKSpriteNode`
        - player: The player object to target
     */
    init(node: SKSpriteNode, player: Player?) {
        super.init(damage: 100, node: node, player: player)
        
        self.elementNode.physicsBody = nil
        self.elementNode.zPosition = -4
    }
    
}
