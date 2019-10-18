//
//  TestCubeSpawnerElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/18/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Cube spawner element
 
 Cube spawners are the equivalent to cube dispensers but do not have a dropper texture; rather, they spawn on the plate in the middle.
 */
class TestCubeSpawnerElement: TestOutputElement {
    
    /**
     The spawned cube element
     */
    var spawnedCube: TestWeightedStorageCubeElement?
    
    /**
     Whether the cube just spawned or not
     */
    private var justSpawned: Bool = false
    
    /**
     Spawn a new cube into the testchamber
     */
    func spawnCube() {
        if self.isActive() {
            if self.spawnedCube != nil {
                self.spawnedCube?.destroy()
                self.spawnedCube = nil
            }
            
            let newCube = TestWeightedStorageCubeElement(atPosition: self.elementNode.position)
            self.elementNode.parent?.addChild(newCube)
            self.spawnedCube = newCube
        }
    }
    
    /**
     Spawn a new cube into the testchamber
     
     This function is designed for cases with constant updates
     */
    func spawnCubeWithUpdate() {
        if self.isActive() && !self.justSpawned {
            self.spawnCube()
            self.justSpawned = true
        } else if !self.isActive() {
            self.justSpawned = false
        }
    }
    
    /**
     Initialize the cube spawner
     - Parameters:
        - inputs: The list of inputs that activate the spawner
        - node: The associated node as a `SKSpriteNode`
        - existingCube: The existing cube object, if any
     */
    init(inputs: [TestInputElement], node: SKSpriteNode, existingCube: TestWeightedStorageCubeElement?) {
        self.spawnedCube = existingCube
        
        super.init(inputs: inputs, node: node, textureName: "Cube_Spawn_Trigger")
        
        if existingCube == nil {
            self.spawnCube()
        }
    }
    
}
