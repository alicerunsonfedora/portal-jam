//
//  ViewController.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/9/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GKScene(fileNamed: "MainMenu") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! SKScene? {
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.skView {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
//                    view.showsFPS = true
//                    view.showsNodeCount = true
                }
            }
        }
    }
}

