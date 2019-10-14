//
//  ChamberScene.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/13/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TestchamberScene: SKScene {
    
    // MARK: Attributes
    
    var exitDoor: SKSpriteNode?
    var walls: [SKSpriteNode]?
    var playerNode: SKSpriteNode?
    var inputs: [SKSpriteNode]?
    
    // MARK: Tile Map Configurations
    
    /**
     Generate all of the appropriate sprite nodes from the layout's tile map.
     
     This function is used to keep track of the walls, doors, and player's starting position in the room. It generates a list of walls and locates the exit door, as well as where the player is.
     
     - Parameters:
        - map: The `SKTileMapNode` to generate the nodes from.
     */
    func configureLayoutFromTilemap(_ map: SKTileMapNode) {
        
        // Create some constants to keep track of things
        let tileMapSize = map.tileSize
        let halfWidth = CGFloat(map.numberOfColumns) / 2.0 * tileMapSize.width
        let halfHeight = CGFloat(map.numberOfRows) / 2.0 * tileMapSize.height
        let tileMapPosition = map.position
        
        // Iterate over every item in the tile map
        for y in 0 ..< map.numberOfColumns {
            for x in 0 ..< map.numberOfRows {
                
                if let tileDefinition = map.tileDefinition(atColumn: y, row: x) {
                    
                    // Get the texture of the tile
                    let tileTextures = tileDefinition.textures
                    let firstTexture = tileTextures[0]
                    
                    // Calculate the tile's position
                    let nodeX = CGFloat(y) * tileMapSize.width - halfWidth + (tileMapSize.width / 2)
                    let nodeY = CGFloat(x) * tileMapSize.height - halfHeight + (tileMapSize.height / 2)
                    
                    // Create a new node with the tile's texture
                    let newTileNode = SKSpriteNode(texture: firstTexture)
                    newTileNode.isHidden = false
                    
                    // Place the node at the calculated position
                    newTileNode.position = CGPoint(x: nodeX, y: nodeY)
                    newTileNode.zPosition = 1
                    
                    // Add the lighting mask
                    newTileNode.lightingBitMask = 0b0001
                    
                    // Assign a physics body to the node and change its properties.
                    newTileNode.physicsBody = SKPhysicsBody(texture: firstTexture,
                                                            size: CGSize(width: (firstTexture.size().width),
                                                                         height: (firstTexture.size().height)))
                    newTileNode.physicsBody?.restitution = 0 // Not bouncy
                    newTileNode.physicsBody?.isDynamic = false // Immovable
                    newTileNode.physicsBody?.affectedByGravity = false
                    newTileNode.physicsBody?.linearDamping = 1000.0 // Dampens velocity between other nodes (eg. stops the player)
                    newTileNode.physicsBody?.allowsRotation = false // Doesn't rotate
                    newTileNode.physicsBody?.friction = 0.7
                    
                    // Check the tile node's definition and create the respective objects.
                    switch (TestchamberStructure.getElementType(byDefinition: tileDefinition.name ?? "")) {
                    
                    // Doors: Attach as the exit door
                    case .door:
                        self.exitDoor = newTileNode
                        break
                        
                    // Players: Assign the player node
                    case .testSubject:
                        self.playerNode = newTileNode
                        break
                        
                    // Buttons: Assign the button to the list of inputs
                    case .button:
                        self.inputs?.append(newTileNode)
                        break
                        
                    // Unknown: Disregard.
                    case .unknown:
                        break
                        
                    // Default (wall): Add to list of walls.
                    default:
                        self.walls?.append(newTileNode)
                        break
                    }
                    
                    
                    // Add the node as a child
                    self.addChild(newTileNode)
                    
                    // Fix the position again
                    newTileNode.position = CGPoint(x: newTileNode.position.x + tileMapPosition.x,
                                                   y: newTileNode.position.y + tileMapPosition.y)
                }
                
            }
        }
        
        // Remove the tilemap
        map.removeFromParent()
    }
    
    // MARK: Overrides
    
    override func didMove(to view: SKView) {
        guard let roomLayout = childNode(withName: "roomLayout") as? SKTileMapNode else {
            fatalError("Room layout is missing. Aborting...")
        }
        self.configureLayoutFromTilemap(roomLayout)
    }
}
