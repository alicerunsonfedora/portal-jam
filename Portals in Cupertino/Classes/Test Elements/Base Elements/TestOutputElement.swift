//
//  TestOutputElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/15/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Base class for an output element. Classes that inherit this class can act as an output that is dependent on input sources.
 */
class TestOutputElement {
    
    private var inputs: [TestInputElement]
    var textureName: String?
    var elementNode: SKSpriteNode
    
    /**
     Check if all inputs are active.
     - Returns: Boolean of whether all inputs are active
     */
    func isActive() -> Bool {
        let inputStatuses = inputs.map({ input in input.getOutput() })
        return inputStatuses.reduce(true, { $0 && $1 })
    }
    
    /**
     Add an input to the list of inputs required.
     - Parameters:
        - input: The input to add to the list of inputs
     */
    func addInput(_ input: TestInputElement) {
        self.inputs.append(input)
    }
    
    /**
     Update the texture based on whether or not the inputs are active.
     
     This depends on the `textureName` property if this was passed during initialization. If this wasn't passed, this function won't do anything.
     */
    func updateTexture() {
        if self.textureName != nil {
            if self.isActive() {
                self.elementNode.texture = SKTexture(imageNamed: self.textureName! + "_Active")
            } else {
                self.elementNode.texture = SKTexture(imageNamed: self.textureName!)
            }
        }
    }
    
    /**
     Initialize the output element.
     - Parameters:
        - inputs: The list of inputs to attach to this output.
     */
    init(inputs: [TestInputElement], node: SKSpriteNode, textureName: String?) {
        self.inputs = inputs
        self.elementNode = node
        self.textureName = textureName
    }
    
}
