//
//  TestWeightedButton.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/15/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class TestWeightedButton: TestInputElement {
    
    init(connectsTo: TestInputType, node: SKSpriteNode, antlines: [SKSpriteNode]?, onConcrete: Bool) {
        var textureName = "Metal_Button"
        
        if onConcrete {
            textureName = textureName.replacingOccurrences(of: "Metal", with: "Concrete")
        }
        
        super.init(connectsTo: connectsTo, node: node, textureName: textureName, antlines: antlines)
    }
    
}
