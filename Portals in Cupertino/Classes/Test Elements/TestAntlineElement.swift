//
//  TestAntlineElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/15/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Indicator lights that determine whether an input has been activated.
 */
class Antline: TestOutputElement {
    
    var type: AntlineType
    var direction: AntlineDirection
    
    // MARK: Shared Functions
    
    /**
     Determine the direction of an antline from a tile definition.
     - Parameters:
        - tileDefinition: The `SKTileDefinition` to check.
     - Returns: The direction of the antline as an `AntlineDirection` enumeration.
     */
    static func determineAntlineDirection(tileDefinition: SKTileDefinition) -> AntlineDirection {
        switch tileDefinition.name {
        case "Antline_Line":
            if tileDefinition.rotation == .rotation90 {
                return .vertical
            } else {
                return .horizontal
            }
        case "Antline_Corner":
            switch tileDefinition.rotation {
            case .rotation0: return .leftToTop
            case .rotation90: return .leftToBottom
            case .rotation180: return .bottomToRight
            case .rotation270: return .topToRight
            @unknown default:
                return .none
            }
        default:
            return .none
        }
    }
    
    /**
     Get the type of antline from a tile definition
     - Parameters:
        - byDefinition: The `SKTileDefinition` name to check against.
     - Returns: The corresponding type as an `AntlineType` enumeration.
     */
    static func getAntlineType(byDefinition: String) -> AntlineType {
        let antline = byDefinition.replacingOccurrences(of: "_Active", with: "")
        
        switch antline {
        case "Antline_Line":
            return .line
        case "Antline_Cross":
            return .cross
        case "Antline_Corner":
            return .corner
        default:
            return .line
        }
    }
    
    /**
     Adjust the roation of the node based on the antline's direction.
     */
    private func adjustNodeRotation() {
        switch self.direction {
        case .vertical:
            self.elementNode.zRotation = .pi / 2
        case .leftToBottom:
            self.elementNode.zRotation = .pi / 2
        case .bottomToRight:
            self.elementNode.zRotation = 2 * .pi
        case .topToRight:
            self.elementNode.zRotation = (3 * .pi) / 2
        default:
            break
        }
    }
    
    
    // MARK: Constructor
    /**
     Initialize an antline.
     - Parameters:
        - inputs: The input elements the antline connects to
        - node: The antline node
        - type: The type of antline (line, corner, cross)
     */
    init(inputs: [TestInputElement], node: SKSpriteNode, type: AntlineType, direction: AntlineDirection) {
        self.type = type
        self.direction = direction
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
        
        self.adjustNodeRotation()
    }
    
}
