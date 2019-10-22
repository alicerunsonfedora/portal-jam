//
//  PortalColors.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/22/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation

enum PortalColor {
    case blue
    case orange
}

enum PortalDirection {
    case north
    case east
    case south
    case west
}

enum PortalError: Error {
    case invalidColor
}
