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
    
    /**
     Check all weighted elements relative to it and activate if a weighted element is in contact with it.
     */
    func checkStatus() {
        let weightedNodes = self.elementNode.parent?.children.filter({ $0 is TestWeightedElement }).map({ node in node as! TestWeightedElement })
        
        if weightedNodes != nil {
            for node in weightedNodes! {
                if self.elementNode.frame.contains(node.position) {
                    self.activate()
                } else {
                    self.deactivate()
                }
            }
        }
    }
    
    /**
     Initialize a weighted button.
     - Parameters:
        - connectsTo: The type of connection.
        - node: The associated `SKSpriteNode`.
        - antlines: Any antlines associated with this input.
     */
    init(connectsTo: TestInputType, node: SKSpriteNode, antlines: [Antline]?) {
        super.init(connectsTo: connectsTo, node: node, textureName: "Weighted_Button", antlines: antlines)
        
    }
    
}
