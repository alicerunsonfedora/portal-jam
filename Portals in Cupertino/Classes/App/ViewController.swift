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
        
        var fileName = "MainMenu"
        
        if CommandLine.arguments.count > 1 {
            
            if CommandLine.arguments.contains("--run-test") {
                let nextIndex = CommandLine.arguments.firstIndex(of: "--run-test")! + 1
                
                if nextIndex < CommandLine.arguments.count {
                    fileName = CommandLine.arguments[nextIndex]
                }
                
            }
            
            if CommandLine.arguments.contains("--skip-menu") {
                fileName = "Sample"
            }
        }
        
        if let scene = GKScene(fileNamed: fileName) {
            
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

