//
//  Testchamber.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/14/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Basic structure to manage testchamber elements.
 */
struct TestchamberStructure {
    
    /**
     Get the respective testing element from a tile definition.
     - Parameters:
        - byDefinition: The `SKTileDefinition` name to check against.
     - Returns: The corresponding `TestElement` enumeration
     */
    static func getElementType(byDefinition: String) -> TestElement {
        switch byDefinition {
        case "Metal_Wall":
            return .metalWall
        case "Concrete_Wall":
            return .concreteWall
        case "Weighted_Cube":
            return .cube
        case "Player":
            return .testSubject
        case "Weighted_Button":
            return .weightedButton
        case "Pedestal_Button":
            return .pedestalButton
        case "Metal_Wall_With_Door":
            return .door
        case "Concrete_Wall_with_Door":
            return .door
        default:
            return .unknown
        }
    }
    
    /**
     Get the type of antline from a tile definition
     - Parameters:
        - byDefinition: The `SKTileDefinition` name to check against.
     - Returns: The corresponding type as an `AntlineType` enumeration.
     */
    
    @available(swift, deprecated: 1.0.0, message: "Has been moved to Antline.getAntlineType")
    static func getAntlineType(byDefinition: String) -> AntlineType {
        return Antline.getAntlineType(byDefinition: byDefinition)
    }
    
}
