//
//  Portal.swift
//  Portals in Cupertino
//
//  Created by Nodar Sotkilava on 10/20/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Portal: SKSpriteNode {
    
    /**
     The other portal associated with this one.
     */
    var connectedSibling: Portal?
    
    /**
     The color of the portal, usually blue or orange.
     */
    var portalColor: PortalColor
    
    /**
     The direction the portal is facing.
     */
    var facing: PortalDirection
    
    /**
     Get the portal's color from the texture name.
     - Parameters:
        - textureName: The name of the texture to sample.
     - Returns: The respective portal color as `PortalColor`
     - Throws: Throws an `invalidColor` error.
     */
    static func getPortalColor(textureName: String) throws -> PortalColor {
        switch textureName {
        case "Blue_Portal":
            return .blue
        case "Orange_Portal":
            return .orange
        default:
            throw PortalError.invalidColor
        }
    }
    
    /**
     Gets the direction the portal is facing.
     - Parameters:
        - fromTile: The tile definition to check against
     */
    static func getPortalDirection(fromTile: SKTileDefinition) {
        // TODO: Implement this stub method
    }
    
    /**
     Determine whether this portal is active.
     
     This is usually determined by seeing if this portal is connected to another portal.
     */
    func isActive() -> Bool {
        return connectedSibling != nil
    }
    
    /**
     Initialize a portal.
     
     - Parameters:
        - color: The color of the portal.
        - facing: The direction of the portal.
        - sibling: The sibling portal, if it exists.
     */
    init(color: PortalColor, facing: PortalDirection, sibling: Portal?) {
        self.portalColor = color
        self.facing = facing
        self.connectedSibling = sibling
        
        var portalTextureName = ""
        
        if self.portalColor == .blue {
            portalTextureName = "Blue_Portal"
        } else {
            portalTextureName = "Orange_Portal"
        }
        
        let portalTexture = SKTexture(imageNamed: portalTextureName)
        
        super.init(texture: portalTexture, color: NSColor.clear, size: portalTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
