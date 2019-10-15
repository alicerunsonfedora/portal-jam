//
//  TestWeightedButtonELement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/15/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class TestWeightedButtonElement: TestInputElement {
    
    init(connectsTo: TestInputType, node: SKSpriteNode, antlines: [Antline]?) {
        super.init(connectsTo: connectsTo, node: node, textureName: "Weighted_Button", antlines: antlines)
    }
    
}
