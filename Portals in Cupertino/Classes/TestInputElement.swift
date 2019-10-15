//
//  TestInputElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/14/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class TestInputElement {
    
    private var outputType: TestInputType
    var elementNode: SKSpriteNode
    private var texture: String
    private var active: Bool = false
    var antlines: [SKSpriteNode]
    
    /**
     Update the texture of the input element based on whether the element is active or not.
     */
    func updateTexture() {
        if active {
            self.elementNode.texture = SKTexture(imageNamed: texture + "_Active")
            
            // TODO: Create an antline texture update call
            for antline in self.antlines {
                antline.texture = SKTexture(imageNamed: texture + "_Active")
            }
        } else {
            self.elementNode.texture = SKTexture(imageNamed: texture)
            
            // TODO: Create an antline texture update call
            for antline in self.antlines {
                antline.texture = SKTexture(imageNamed: texture)
            }
        }
    }
    
    /**
     Get the output value of the input element.
     
     - Returns: Boolean of whether the element is active.
     */
    func getOutput() -> Bool {
        return self.active
    }
    
    /**
     Activate the input.
     */
    func activate() {
        self.active = true
        self.updateTexture()
    } 
    
    /**
     Deactivate the input.
     */
    func deactivate() {
        self.active = false
        self.updateTexture()
    }
    
    /**
     Construct a TestInputElement object.
     - Parameters:
        - connectsTo: The type of input (either `.toExit` or `.toElement`)
        - node: The `SKSpriteNode` to associate with
        - textureName: The name of the texture to use for the sprite node
        - antlines: The list containing all of the antline tiles associated with the input
     */
    init(connectsTo: TestInputType, node: SKSpriteNode, textureName: String, antlines: [SKSpriteNode]) {
        self.outputType = connectsTo
        self.elementNode = node
        self.texture = textureName
        self.antlines = antlines
    }
    
}
