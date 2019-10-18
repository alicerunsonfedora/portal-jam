//
//  TestWeightedStorageCubeElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/17/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 A weighted storage cube.
 
 Weighted storage cubes can hold down weighted buttons (`TestWeightedButtonElement`) or interact with elements dependent on weight.
 */
class TestWeightedStorageCubeElement : TestWeightedElement {
    
    func destroy() {
        self.run(SKAction.colorize(with: NSColor.black, colorBlendFactor: 0.8, duration: 3.0))
        self.run(SKAction(named: "Vaporize", duration: 3.0)!) {
            self.removeFromParent()
        }
    }
    
    /**
     Initialize a Weighted Storage Cube that can interact with Weighted Buttons.
     - Parameters:
        - atPosition: The position of the node (`CGPoint`)
     */
    init(atPosition: CGPoint) {
        let weightedCubeTexture = SKTexture(imageNamed: "Weighted_Cube")
        
        super.init(texture: weightedCubeTexture, weighted: true)
        
        self.isHidden = false
        self.position = atPosition
        self.zPosition = 3
        self.lightingBitMask = 0b0001
        
        self.physicsBody = SKPhysicsBody(texture: weightedCubeTexture, alphaThreshold: 0.9, size: weightedCubeTexture.size())
        self.physicsBody?.restitution = 0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 40
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
