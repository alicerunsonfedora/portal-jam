//
//  TestVictoryLiftElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/21/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class TestVictoryLiftElement {
    
    var transportLocation: String
    var view: SKView?
    var elementNode: SKSpriteNode
    
    func watchForActivation() {
        let playerMap = self.elementNode.parent?.children.filter({ $0 is Player }).map({ node in node as! Player })
        let player: Player? = playerMap?[0]
        
        if player != nil {
            if player!.isCloseTo(node: self.elementNode) {
                self.transportToLocation()
            }
        }
        
    }
    
    func transportToLocation() {
        let transportScene = SKScene(fileNamed: transportLocation)
                
        if transportScene != nil {
            self.view?.presentScene(transportScene!, transition: SKTransition.fade(with: NSColor.black, duration: 4.0))
        } else {
            print("Cannot find the testchamber or scene named \(transportLocation). Are you sure this scene exists?")
        }
    }
    
    init(toLocation: String, node: SKSpriteNode, view: SKView?) {
        self.transportLocation = toLocation
        self.elementNode = node
        self.view = view
        
        self.elementNode.physicsBody = nil
        self.elementNode.zPosition = -2
    }
    
}
