//
//  TestVictoryLiftElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/21/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 A victory lift.
 
 Victory lifts typically transport players to the next available testchamber as described in `transportLocation`. These should be used only a segues to other SpriteKit scenes.
 */
class TestVictoryLiftElement {
    
    /**
     The name of the scene to transport to
     */
    var transportLocation: String
    
    /**
     The view to present the transporting scene with
     */
    var view: SKView?
    
    /**
     The associated `SKSpriteNode`
     */
    var elementNode: SKSpriteNode
    
    /**
     Check to see if the player has stepped on the victory lift.
     
     If the player is on the victory lift, an animation  will play where the player realigns themself on the victory lift and then the new scene will be presented.
     */
    func watchForActivation() {
        let playerMap = self.elementNode.parent?.children.filter({ $0 is Player }).map({ node in node as! Player })
        let player: Player? = playerMap?[0]
        
        if player != nil {
            if player!.isCloseTo(node: self.elementNode) {
                player!.run(SKAction.move(to: self.elementNode.position, duration: 0.75)) {
                    player!.run(SKAction.rotate(toAngle: (3 * .pi) / 2, duration: 1.5)) {
                        self.transportToLocation()
                    }
                }
            }
        }
        
    }
    
    /**
     Present the new scene, if possible.
     */
    func transportToLocation() {
        let transportScene = SKScene(fileNamed: transportLocation)
                
        if transportScene != nil {
            self.view?.presentScene(transportScene!, transition: SKTransition.fade(with: NSColor.black, duration: 4.0))
        } else {
            print("Cannot find the testchamber or scene named \(transportLocation). Are you sure this scene exists?")
        }
    }
    
    /**
     Initialize a victory lift.
     - Parameters:
        - toLocation: The SKScene name to transport to
        - node: The node to associate the victory lift with
        - view: The `SKView` to control for presentation
     */
    init(toLocation: String, node: SKSpriteNode, view: SKView?) {
        self.transportLocation = toLocation
        self.elementNode = node
        self.view = view
        
        self.elementNode.physicsBody = nil
        self.elementNode.zPosition = -2
    }
    
}
