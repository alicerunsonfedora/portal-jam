//
//  TestAntlineElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/15/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Antline: TestOutputElement {
    
    var type: AntlineType
    
    init(inputs: [TestInputElement], node: SKSpriteNode, type: AntlineType) {
        self.type = type
        var textureName = ""
        
        switch type {
        case .line:
            textureName = "Antline_Line"
            break
        case .corner:
            textureName = "Antline_Corner"
            break
        case .cross:
            textureName = "Antline_Cross"
        }
        
        super.init(inputs: inputs, node: node, textureName: textureName)
    }
    
}
