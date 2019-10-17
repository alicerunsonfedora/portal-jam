//
//  AntlineType.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/14/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 A specified antline pattern.
 */
enum AntlineType {
    
    /**
     A line, either horizontal or vertical.
     */
    case line
    
    /**
     A corner-styled pattern.
     */
    case corner
    
    /**
     A cross-styled pattern.
     */
    case cross
}

/**
 The direction an antline can face.
 */
enum AntlineDirection {
    /**
     A horizontal line.
     */
    case horizontal
    
    /**
     A vertical line.
     */
    case vertical
    
    /**
     A corner with connections from both the north and west sides.
     */
    case leftToTop
    
    /**
     A corner with connections from both the north and east sides.
     */
    case topToRight
    
    /**
     A corner with connections from both the south and west sides.
     */
    case leftToBottom
    
    /**
     A corner with connection from both the south and east sides.
     */
    case bottomToRight
    
    /**
     An unknown or directionless pattern. Use this as a "catch-all".
     */
    case none
}
