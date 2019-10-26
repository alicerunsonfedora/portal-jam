//
//  UIScene.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/20/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class UIScene: SKScene {
    
    var previousScene: String?
    
    func goBack() {
        self.view?.presentScene(SKScene(fileNamed: previousScene!)!, transition: SKTransition.fade(with: NSColor.black, duration: 2.0))
    }
    
    override func didMove(to view: SKView) {
        
        let prevSceneName = self.userData?.object(forKey: "previousScene") as! String
        
        guard SKScene(fileNamed: prevSceneName) != nil else {
            fatalError("Failed to get the previous scene. Was this not set?")
        }
        
        self.previousScene = prevSceneName
        
    }
    
}
