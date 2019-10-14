//
//  File.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/14/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation

enum TestElement {
    case concreteWall
    case metalWall
    case button
    case door
    case testSubject
    case unknown
}

struct TestchamberStructure {
    
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
    
}
