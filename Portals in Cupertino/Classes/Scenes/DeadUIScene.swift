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
    var menuButton: SKLabelNode?
    var flavorTextNode: SKLabelNode?
    let defaultMessage = "Through no fault of the Enrichment Center, you have managed to kill yourself, thus we can no longer accept your test results."
    let possibleMessages = [
        "I honestly didn't think you'd fall for that.",
        "What a disappointment.",
        "Oh, well. I'll just test the others that are more competent than you.",
        "I should've seen that coming.",
        "Dying is NOT a part of the test."
    ]
    
    func pickMessage() {
        self.flavorTextNode?.text = possibleMessages.randomElement() ?? defaultMessage
    }
    
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        let touchedNode = self.atPoint(location)
                
        switch touchedNode {
        case restartButton:
            self.goBack()
            break
        case menuButton:
            self.view?.presentScene(SKScene(fileNamed: "MainMenu")!)
        default:
            break
        }
    }
    
    override func didMove(to view: SKView) {
        self.restartButton = childNode(withName: "RestartButton") as! SKLabelNode?
        self.menuButton = childNode(withName: "MainMenuButton") as! SKLabelNode?
        self.flavorTextNode = childNode(withName: "Flavor") as! SKLabelNode?
        
        super.didMove(to: view)
        
        self.pickMessage()
    }
    
}
