//
//  TestWeightedElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/16/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Base class for weighted elements. Classes that inherit this class are given "weight".
 
 This class is typically used to help identify triggers for input sources or anything that would require weighted objects such as the weighted storage cube or the player. This is an inherited `SKSpriteNode` with an extra weighted property.
 */
class TestWeightedElement: SKSpriteNode {
    
    /**
     Whether the element is weighted. Defaults to `true`.
     */
    var weighted: Bool = true
    
    /**
     Initialize a weighted object.
     - Parameters:
        - texture: The corresponding `SKTexture` for the `SKSpriteNode`
        - weighted: Whether this item has weight or not. Defaults to `true`.
     */
    init(texture: SKTexture?, weighted: Bool) {
        self.weighted = false
        super.init(texture: texture, color: NSColor.clear, size: (texture?.size())!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
