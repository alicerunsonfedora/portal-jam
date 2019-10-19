//
//  File.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/14/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 A specific type of test element. Useful for generating individual nodes.
 */
enum TestElement {
    /**
     A portalable, concrete wall.
     */
    case concreteWall
    
    /**
     A non-portable, metal wall.
     */
    case metalWall
    
    /**
     A weighted button.
     */
    case weightedButton
    
    /**
     A pedestal button
     */
    case pedestalButton
    
    /**
     A cube spawner
     */
    case cubeSpawner
    
    /**
     A door, either an exit or standard.
     */
    case door
    
    /**
     A weighted storage cube.
     */
    case cube
    
    /**
     A test subject (usually the player).
     */
    case testSubject
    
    /**
     Deadly goo.
     */
    case goo
    
    /**
     An unknown element. Use this as the "catch-all".
     */
    case unknown
}
