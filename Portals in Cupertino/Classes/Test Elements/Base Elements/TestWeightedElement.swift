//
//  TestWeightedElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/16/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class TestWeightedElement: SKSpriteNode {
    
    var weighted: Bool
    
    init(texture: SKTexture?, weighted: Bool) {
        self.weighted = false
        super.init(texture: texture, color: NSColor.clear, size: (texture?.size())!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
