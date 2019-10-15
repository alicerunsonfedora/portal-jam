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
        case "Player":
            return .testSubject
        case "Concrete_Button":
            return .button
        case "Metal_Button":
            return .button
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
    
}
