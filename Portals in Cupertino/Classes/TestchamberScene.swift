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
        
        // Create the appropriate door textures (used to track the type of obstructions) and player texture
        let metalDoorTexture = SKTexture(imageNamed: "Metal_Wall_With_Door")
        let concreteDoorTexture = SKTexture(imageNamed: "Concrete_Wall_with_Door")
        let playerTexture = SKTexture(imageNamed: "Player")
        let metalButtonTexture = SKTexture(imageNamed: "Metal_Button")
        let concreteButtonTexture = SKTexture(imageNamed: "Concrete_Button")
        
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
                    
                    newTileNode.lightingBitMask = 0b0001
                    newTileNode.shadowCastBitMask = 0b0001
                    
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
                    
                    // Check the tile node's texture. If it's a player or door, treat it differently.
                    if (newTileNode.texture != nil) {
                        switch (newTileNode.texture) {
                        // Doors: Assign it as the exit door
                        case (metalDoorTexture):
                            self.exitDoor = newTileNode
                            break;
                        case (concreteDoorTexture):
                            self.exitDoor = newTileNode
                            break;
                        // Buttons: Assign them as inputs
                        case (metalButtonTexture):
                            newTileNode.zPosition = 0
                            self.inputs?.append(newTileNode)
                            break;
                        case (concreteButtonTexture):
                            newTileNode.zPosition = 0
                            self.inputs?.append(newTileNode)
                            break;
                        // Player: Assign it as the player
                        case (playerTexture):
                            newTileNode.physicsBody?.isDynamic = true
                            self.playerNode = newTileNode
                            break;
                        // Walls: Add it to list of walls
                        default:
                            self.walls?.append(newTileNode)
                            break;
                        }
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
