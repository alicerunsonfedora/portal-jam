//
//  MainMenuUIScene.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/20/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuUIScene: SKScene {
    
    var titleNode: SKLabelNode?
    var startButton: SKLabelNode?
    var quitButton: SKLabelNode?
        
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        let touchedNode = self.atPoint(location)
        
        switch touchedNode {
        case startButton:
            self.view?.presentScene(SKScene(fileNamed: "Sample")!, transition: SKTransition.fade(with: NSColor.black, duration: 1.0))
        case quitButton:
            exit(0)
        default:
            break
        }
    }
    
    override func didMove(to view: SKView) {
        
        self.titleNode = childNode(withName: "Title") as! SKLabelNode?
        self.startButton = childNode(withName: "StartButton") as! SKLabelNode?
        self.quitButton = childNode(withName: "QuitButton") as! SKLabelNode?
        
    }
    
}
