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
import Carbon.HIToolbox

/**
 A basic testchamber scene with tilemaps for a test layout.
 
 Each testchamber should include and exit door, a player, inputs, outputs, and a camera that follows the player. Testchambers made with SpriteKit use this class to set up the scene and make it solvable/playable.
 
 - Important:
 It is important to note that the testchamber should also have a room layout with walls, deadly elements, and the victory lift. The layout's tile map needs the `exitsTo` user data field if it contains a victory lift to control where the victory lift will transport the player to.
 
 - Requires:
    Each testchamber should have a layout like the following:
 
    - `backgroundLayout`: A tilemap node containing the basic floor layout. Usually has a `zPosition` of `-20`.
    - `floorDecorLayout`: A tilemap node containing the floor signage. Usually has a `zPosition` of `-10`.
    - Input layers, prefixed with `input_`: Tilemaps containing all of the inputs and outputs of the testchamber. Each input should have a child tilemap for antlines, though that tilemap _can_ be empty. There also _must_ be an `input_exitLayout` tilemap for the exit door. These should be reasonably placed in the z-axis.
    - `roomLayout`: A tilemap node containg all of the walls, deadly elements, victory lift, and player tiles. The z-position won't matter much since this class will handle all of the "parsing".
    - `decorLayout`: A tilemap node containing all of the signange on the walls.  Usually has a `zPosition` of `20`.
    - `playerCamera`: A camera node placed over the player's head.
    - Light nodes: Light nodes for lighting up the scene.
 */
class TestchamberScene: SKScene {
    
    // MARK: Attributes
    
    /**
     The testchamber's exit door.
     */
    var exitDoor: TestDoorElement?
    
    /**
     A list containing all of the walls in this testchamber.
     */
    var walls: [SKSpriteNode]?
    
    /**
     A list containing all of the deadly elements in this testchamber such as deadly goo or turrets.
     */
    var deadlyElements: [TestDeadlyElement]?
    
    /**
     The main player node.
     */
    var playerNode: Player?
    
    /**
     A list containing the inputs in this testchamber.
     */
    var inputs: [TestInputElement]?
    
    /**
     A list containing the outputs in this testchamber.
     */
    var outputs: [TestOutputElement]?
    
    /**
     The main camera node attached to the player.
     */
    var cameraNode: SKCameraNode?
    
    /**
     The victory lift for this testchamber.
     */
    var victoryLift: TestVictoryLiftElement?
    
    // MARK: Tile Map Configurations
    
    /**
     Parses through a tilemap and perform an action on each tile node.
     
     This function is primarily a higher-order function that will calculate properties of the tilemap and then proceed to iterate over every tile in the tilemap based on the `parse` function defined, either as a parameter or as a closure.
     
     - Parameters:
        - map: The `SKTileMapNode` to parse.
        - parse: The function to determine how to parse the tilemap.
     
     - Important:
    The parse function should consider the following parameters passed to it (in order of the list):
        - The tile definition itself (`SKTileDefinition`)
        - A coordinate point containing the iterated point in the tile map (eg. it's x and y) (`CGPoint`)
        - The size of the tile. (`CGSize`)
        - The calculated hald-width (`CGFloat`)
        - The calculate half-height (`CGFloat`)
        - The map's own position (`CGPoint`)
     This function should also be void, meaning that there isn't a return statement.
     */
    func parseTileMap(_ map: SKTileMapNode, parse: ((SKTileDefinition, CGPoint, CGSize, CGFloat, CGFloat, CGPoint) -> Void)) {
        // Grab the position and the size of the tilemap for reference
        let mapSize = map.tileSize
        let halfWidth = CGFloat(map.numberOfColumns) / 2.0 * mapSize.width
        let halfHeight = CGFloat(map.numberOfRows) / 2.0 * mapSize.height
        let mapPosition = map.position
        
        for y in 0 ..< map.numberOfColumns {
            for x in 0 ..< map.numberOfRows {
                if let tileDefinition = map.tileDefinition(atColumn: y, row: x) {
                    parse(tileDefinition, CGPoint(x: x, y: y), mapSize, halfWidth, halfHeight, mapPosition)
                }
            }
        }
        
    }
    
    /**
     Generate all of the appropriate sprite nodes from the layout's tile map.
     
     This function is used to keep track of the walls, doors, and player's starting position in the room. It generates a list of walls and locates the exit door, as well as where the player is.
     
     - Parameters:
        - map: The `SKTileMapNode` to generate the nodes from.
     */
    func configureLayoutFromTilemap(_ map: SKTileMapNode) {
        
        // Create an empty goo array
        var deadlyElementList = [TestDeadlyElement]()
        var player: Player?
        
        self.parseTileMap(map){ tileDefinition, coordinate, tileMapSize, halfWidth, halfHeight, tileMapPosition in
                
            let x = coordinate.x
            let y = coordinate.y
            
            let tileTextures = tileDefinition.textures
            let firstTexture = tileTextures[0]
            let elementType = TestchamberStructure.getElementType(byDefinition: tileDefinition.name!)
            
            // Calculate the tile's position
            let nodeX = CGFloat(y) * tileMapSize.width - halfWidth + (tileMapSize.width / 2)
            let nodeY = CGFloat(x) * tileMapSize.height - halfHeight + (tileMapSize.height / 2)
            
            // Create a new node with the tile's texture. If it's a player,
            // use the Player class instead.
            var newTileNode = SKSpriteNode(texture: firstTexture)
            
            
            if elementType == .testSubject {
                newTileNode = Player(texture: firstTexture, camera: self.cameraNode)
            }

            newTileNode.isHidden = false
            
            // Place the node at the calculated position
            newTileNode.position = CGPoint(x: nodeX, y: nodeY)
            newTileNode.zPosition = 1
            
            // Add the lighting mask
            newTileNode.lightingBitMask = 0b0001
            
            // Assign a physics body to the node and change its properties.
            if (elementType != .testSubject) {
                newTileNode.physicsBody = SKPhysicsBody(texture: firstTexture,
                                  size: CGSize(width: (firstTexture.size().width),
                                  height: (firstTexture.size().height)))
                newTileNode.physicsBody?.restitution = 0 // Not bouncy
                newTileNode.physicsBody?.isDynamic = false // Immovable
                newTileNode.physicsBody?.affectedByGravity = false
                newTileNode.physicsBody?.linearDamping = 1000.0 // Dampens velocity between other nodes (eg. stops the player)
                newTileNode.physicsBody?.allowsRotation = false // Doesn't rotate
                newTileNode.physicsBody?.friction = 0.7
            }
            
            
            // Check the tile node's definition and create the respective objects.
            switch (elementType) {
                
            // Players: Assign the player node and add this to every deadly item.
            case .testSubject:
                if newTileNode is Player {
                    player = newTileNode as? Player
                }
                
                for deadlyElement in deadlyElementList {
                    deadlyElement.assignPlayer(to: player)
                }
                
                break
            
            // Deadly Goo: Create deadly goo and watch the current player
            case .goo:
                let goo = TestGooElement(node: newTileNode, player: self.playerNode)
                deadlyElementList.append(goo)
                break
                
            // Victory lifts: Create the victory lift and watch this scene and the player.
            case .victoryLift:
                let location = map.userData?.object(forKey: "exitsTo") as? String ?? ""
                self.victoryLift = TestVictoryLiftElement(toLocation: location, node: newTileNode, view: self.view)
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
        // Assign the player and any goo
        self.deadlyElements = self.deadlyElements ?? [] + deadlyElementList
        self.playerNode = player
        
        // Remove the tilemap
        map.removeFromParent()
        
    }
    
    /**
     Takes a schematic and adds any inputs and outputs to the current layout.
     - Parameters:
        - map: The `SKTileMapNode` to "parse" as a set of inputs and outputs.
     */
    func configureInputSchematic(_ map: SKTileMapNode) {
        
        // Set some constants
        let isExitLayout = map.name?.contains("exitLayout")
        
        // Grab the antline tilemap, if it exists.
        guard let antlineTilemap = map.childNode(withName: map.name! + "_antlines") as! SKTileMapNode? else {
            fatalError("Antline connections to this map are missing. Aborting...")
        }
        
        // Create an empty antline array and input/output array.
        var antlines = [Antline]()
        var inputs = [TestInputElement]()
        var outputs = [TestOutputElement]()
        var cube: TestWeightedStorageCubeElement?
        
        //Iterate over every antline element
        self.parseTileMap(antlineTilemap) { antlineDefinition, coordinate, tileMapSize, halfWidth, halfHeight, tileMapPosition in
            
            let x = coordinate.x
            let y = coordinate.y
            
            let antlineType = Antline.getAntlineType(byDefinition: antlineDefinition.name!)
                                                    
            // Gather the textures
            let antlineTextures = antlineDefinition.textures
            let antlineTexture = antlineTextures[0]
            
            // Calculate the tile's position
            let antlineX = CGFloat(y) * tileMapSize.width - halfWidth + (tileMapSize.width / 2)
            let antlineY = CGFloat(x) * tileMapSize.height - halfHeight + (tileMapSize.height / 2)
            
            // Create the new node.
            let antlineNode = SKSpriteNode(texture: antlineTexture)
            
            // Set some basic properties.
            antlineNode.isHidden = false
            antlineNode.position = CGPoint(x: antlineX, y: antlineY)
            antlineNode.zPosition = -1
            antlineNode.lightingBitMask = 0b0001
            
            // Create a new Antline object and add it to the antline list.
            let newAntline = Antline(inputs: [],
                                     node: antlineNode,
                                     type: antlineType,
                                     direction: Antline.determineAntlineDirection(tileDefinition: antlineDefinition))
            antlines.append(newAntline)
            self.addChild(antlineNode)
                                
            // Fix the position again
            antlineNode.position = CGPoint(x: antlineNode.position.x + tileMapPosition.x,
                                           y: antlineNode.position.y + tileMapPosition.y)
            
        }
        
        // Iterate over every item in the parent tilemap.
        self.parseTileMap(map) { tileDefinition, coordinate, tileMapSize, halfWidth, halfHeight, tileMapPosition in
            
            let x = coordinate.x
            let y = coordinate.y
            
            // Get the type of element
            let elementType = TestchamberStructure.getElementType(byDefinition: tileDefinition.name!)
            
            // Gather the textures
            let tileTextures = tileDefinition.textures
            let firstTexture = tileTextures[0]
            
            // Calculate the tile's position
            let nodeX = CGFloat(y) * tileMapSize.width - halfWidth + (tileMapSize.width / 2)
            let nodeY = CGFloat(x) * tileMapSize.height - halfHeight + (tileMapSize.height / 2)
            
            // Create the new node.
            var newTileNode = SKSpriteNode(texture: firstTexture)
            
            // Set some basic properties.
            newTileNode.isHidden = false
            newTileNode.position = CGPoint(x: nodeX, y: nodeY)
            newTileNode.zPosition = 0
            newTileNode.lightingBitMask = 0b0001
            
            switch elementType {
            case .cube:
                newTileNode = TestWeightedStorageCubeElement(atPosition: CGPoint(x: nodeX, y: nodeY))
                cube = newTileNode as? TestWeightedStorageCubeElement
                break
            case .door:
                if isExitLayout! {
                    if self.exitDoor == nil {
                        self.exitDoor = TestDoorElement(inputs: inputs, node: newTileNode, isMetalWall: tileDefinition.name!.contains("Metal"))
                    }
                } else {
                    outputs.append(TestDoorElement(inputs: inputs, node: newTileNode, isMetalWall: tileDefinition.name!.contains("Metal")))
                    print(outputs)
                }
                break
            case .weightedButton:
                var button: TestWeightedButtonElement?
                
                if isExitLayout! {
                    button = TestWeightedButtonElement(connectsTo: .toExit, node: newTileNode, antlines: antlines)
                    self.exitDoor?.addInput(button!)
                } else {
                    button = TestWeightedButtonElement(connectsTo: .toElement, node: newTileNode, antlines: antlines)
                }
                
                inputs.append(button!)
                for antline in antlines {
                    antline.addInput(button!)
                }
                
                for output in outputs {
                    output.addInput(button!)
                }
                break
            case .pedestalButton:
                var button: TestPedestalButton?
                let direction = TestPedestalButton.getPedestalDirection(forButtonDefinition: tileDefinition)
                
                if isExitLayout! {
                    button = TestPedestalButton(timeoutAfter: map.userData?.object(forKey: "buttonTimeout") as? Double,
                                                connectsTo: .toExit,
                                                node: newTileNode,
                                                antlines: antlines,
                                                inDirection: direction)
                    self.exitDoor?.addInput(button!)
                } else {
                    button = TestPedestalButton(timeoutAfter: map.userData?.object(forKey: "buttonTimeout") as? Double,
                                                connectsTo: .toElement,
                                                node: newTileNode,
                                                antlines: antlines,
                                                inDirection: direction)
                }
                
                for antline in antlines {
                    antline.addInput(button!)
                }
                
                for output in outputs {
                    output.addInput(button!)
                }
                
                inputs.append(button!)
                
            case .cubeSpawner:
                let spawner = TestCubeSpawnerElement(inputs: inputs, node: newTileNode, existingCube: cube)
                outputs.append(spawner)
            default:
                break
            }
                                
            self.addChild(newTileNode)
            
            // Fix the position again
            newTileNode.position = CGPoint(x: newTileNode.position.x + tileMapPosition.x,
                                           y: newTileNode.position.y + tileMapPosition.y)
            
        }
        
        // Add the inputs and outputs
        self.inputs = (self.inputs ?? []) + inputs
        self.outputs = (self.outputs ?? []) + outputs
        
        // Finally, remove the tilemaps
        antlineTilemap.removeFromParent()
        map.removeFromParent()
    }
    
    // MARK: Overrides
    
    
    override func mouseMoved(with event: NSEvent) {
        //Gets the mouse position and player's
        let location = event.location(in: self)
        let playerX = playerNode?.position.x
        let playerY = playerNode?.position.y
        let targetX = location.x
        let targetY = location.y
        
        //Gets the angle between the two and makes that the direction move the player to face
        let rotation = atan2((targetY - playerY!), (targetX - playerX!))
        playerNode?.zRotation = rotation - (.pi / 2)
    }
    
    
    override func keyDown(with event: NSEvent) {
        //Gets the code of the key pressed on the keyboard
        switch Int(event.keyCode) {
        case kVK_ANSI_A:
            //Strafes player to the left relative to the direction they're facing
            playerNode?.moveTo(direction: CGPoint(x: (playerNode?.position.x)! - sin(playerNode!.zRotation + (.pi/2)) * 10,
                                                  y: (playerNode?.position.y)! + cos(playerNode!.zRotation + (.pi/2)) * 10))
        case kVK_ANSI_D:
            //Strafes player to the right relative to the direction they're facing
            playerNode?.moveTo(direction: CGPoint(x:(playerNode?.position.x)! - sin(playerNode!.zRotation - (.pi/2)) * 10,
                                                  y: ((playerNode?.position.y)! + cos(playerNode!.zRotation - (.pi/2)) * 10)))
        case kVK_ANSI_W:
            //Moves player forward to the direction they're facing
            playerNode?.moveTo(direction: CGPoint(x:(playerNode?.position.x)! - sin(playerNode!.zRotation) * 10,
                                                  y:(playerNode?.position.y)! + cos(playerNode!.zRotation) * 10))
        case kVK_ANSI_S:
            //Moves player
            playerNode?.moveTo(direction: CGPoint(x:(playerNode?.position.x)! + sin(playerNode!.zRotation) * 10,
                                                  y:(playerNode?.position.y)! - cos(playerNode!.zRotation) * 10))
            break
        
        case kVK_ANSI_E:
            if (playerNode?.isCarrying ?? false) {
                playerNode?.dropItem()
            }
            else {
                playerNode?.grabItem()
            }
            
            if self.inputs != nil {
                for input in self.inputs! {
                    if input is TestPedestalButton {
                        let pedestalButton = input as! TestPedestalButton
                        if (self.playerNode?.isCloseTo(node: pedestalButton.elementNode))!
                            && (self.playerNode?.isFacing(node: pedestalButton.elementNode))! {
                            pedestalButton.use()
                        }
                    }
                }
            }
            break
        default:
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Update the camera's position
        cameraNode?.position = playerNode!.position
        
        // Display the "dead" scene if the player is dead
        if (self.playerNode?.isDead)! {
            let deathScene = DeadUIScene(fileNamed: "Dead")!
            let deadColor = #colorLiteral(red: 0.3031606916, green: 0.01700964238, blue: 0, alpha: 1)
            deathScene.userData = NSMutableDictionary()
            deathScene.userData?.setObject(self.name!, forKey: "previousScene" as NSCopying)
            self.view?.presentScene(deathScene, transition: SKTransition.fade(with: deadColor, duration: 3.0))
        }
        
        // Toggle the door if necessary
        self.exitDoor?.toggleDoor()
        
        // Watch if the player steps on the victory lift
        self.victoryLift?.watchForActivation()
        
        // Check all deadly elements
        if self.deadlyElements != nil {
            for deadlyElement in self.deadlyElements! {
                switch deadlyElement {
                case (is TestGooElement):
                    (deadlyElement as! TestGooElement).scanForDamage()
                    break
                default:
                    break
                }
            }
        }
        
        // Check all inputs
        if self.inputs != nil {
            for input in self.inputs! {
                if input is TestWeightedButtonElement {
                    let button = input as! TestWeightedButtonElement
                    button.checkStatus()
                }
            }
        }
        
        // Check all outputs
        if self.outputs != nil {
            for output in self.outputs! {
                switch output {
                case (is TestDoorElement):
                    (output as! TestDoorElement).toggleDoor()
                    break
                case (is TestCubeSpawnerElement):
                    (output as! TestCubeSpawnerElement).spawnCubeWithUpdate()
                    break
                default:
                    break
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        // Set up the tracking area
        let trackingArea = NSTrackingArea(rect: view.frame, options: [.activeInKeyWindow, .mouseMoved, .inVisibleRect], owner: self, userInfo: nil)
        view.addTrackingArea(trackingArea)
        
        // Set the default ambience color
        self.backgroundColor = #colorLiteral(red: 0.146314883, green: 0.2027438601, blue: 0.236890763, alpha: 1)
        
        // Set up the camera
        self.cameraNode = childNode(withName: "playerCamera") as? SKCameraNode

        // Start developing the room layout
        guard let roomLayout = childNode(withName: "roomLayout") as? SKTileMapNode else {
            fatalError("Room layout is missing. Aborting...")
        }
        self.configureLayoutFromTilemap(roomLayout)
        
        // Start developing the input layers
        for layout in children.filter({ ($0.name?.starts(with: "input_") ?? false) }) {
            self.configureInputSchematic((layout as? SKTileMapNode)!)
        }
        
    }
}
