//
//  DeadUIScene.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/20/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class DeadUIScene: UIScene {
    
    var restartButton: SKLabelNode?
    var flavorTextNode: SKLabelNode?
    
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        let touchedNode = self.atPoint(location)
                
        if touchedNode == restartButton {
            self.goBack()
        }
    }
    
    override func didMove(to view: SKView) {
        self.restartButton = childNode(withName: "RestartButton") as! SKLabelNode?
        self.flavorTextNode = childNode(withName: "Flavor") as! SKLabelNode?
        
        super.didMove(to: view)
    }
    
}
