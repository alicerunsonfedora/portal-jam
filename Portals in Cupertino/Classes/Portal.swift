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
     Teleport the player node to this portal's sibling if possible. The player must be in range of the portal and colliding with it.
     - Parameters:
        - player: The `Player` node to teleport.
     */
    func teleportToSibling(player: Player?) {
        
        if self.isPortalEntryValid(player: player) {
            var pos = self.connectedSibling?.position
            let offset: CGFloat = 32.0
            
            switch connectedSibling!.facing {
            case .north:
                pos!.y += offset
                break
            case .south:
                pos!.y -= offset
                break
            case .west:
                pos!.x -= offset
                break
            case .east:
                pos!.x += offset
            }
            
            player!.position = pos!
            player?.zRotation = (self.connectedSibling?.getRotation())!
        }
    }
    
    func isPortalEntryValid(player: Player?) -> Bool {
        if connectedSibling != nil {
            let portalBody = self.physicsBody
            guard let playerBody = player?.physicsBody else { return false }
            if player!.isCloseTo(node: self) {
                return player!.isFacing(node: self) && (portalBody?.allContactedBodies().contains(playerBody))!
            } else {
                return false
            }
            
        } else {
            return false
        }
    }
        
    /**
     Gets the portal's neighboring tiles.
     - Parameters:
        - inLayout: The list of walls to check.
     - Returns: A list of `SKNode` that are the portal's neighbors
     */
    func getNeighbors(inLayout: [SKNode]) -> [SKNode] {
        var neighbors = [SKNode]()
        
        print(inLayout)
        
        let positions = [
            CGPoint(x: position.x, y: position.y + 128),
            CGPoint(x: position.x, y: position.y - 128),
            CGPoint(x: position.x - 128, y: position.y),
            CGPoint(x: position.x + 128, y: position.y)]
        
        for wall in inLayout {
            if positions.contains(wall.position) {
                neighbors.append(wall)
            }
        }
        
        return neighbors
    }
    
    /**
     Gets the inverse rotation as defined by the portal's texture.
     - Returns: The proper angle in radians (`CGFloat`).
     */
    func getInverseRotation() -> CGFloat {
        switch facing {
        case .south:
            return .pi
        case .west:
            return .pi / 2
        case .east:
            return 3 * .pi / 2
        default:
            return 2 * .pi
        }
    }
    
    /**
     Gets the rotation as defined by the portal's texture.
     - Returns: The proper angle in radians (`CGFloat`).
     */
    func getRotation() -> CGFloat {
        switch facing {
        case .north:
            return .pi
        case .east:
            return .pi / 2
        case .west:
            return 3 * .pi / 2
        default:
            return 2 * .pi
        }
    }
    
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
     
     The direction is typically flipped from the texture. For example, if a portal is facing `east`, the portal will appear on the _left_ side of the node texture.
     
     - Parameters:
        - fromTile: The tile definition to check against
     */
    static func getPortalDirection(fromTile: SKTileDefinition) -> PortalDirection {
        
        // The texture's rotation is opposite to what you would expect since the portal is at the
        // bottom of the image.
        
        switch fromTile.rotation {
        case .rotation0:
            return .south
        case .rotation90:
            return .east
        case .rotation180:
            return .north
        case .rotation270:
            return .west
        default:
            return .south
        }
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
        
        self.zPosition = 5
        self.physicsBody = SKPhysicsBody(texture: portalTexture, alphaThreshold: 0.9, size: portalTexture.size())
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.restitution = 0
        
                
        switch facing {
        case .north:
            self.zRotation = .pi
        case .east:
            self.zRotation = .pi / 2
        case .west:
            self.zRotation = 3 * .pi / 2
        default:
            break
        }
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
