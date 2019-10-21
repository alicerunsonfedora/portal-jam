//
//  Portals.swift
//  Portals in Cupertino
//
//  Created by Nodar Sotkilava on 10/20/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Portal: SKSpriteNode{

    private var active: Bool = false
    //var connectedPortal: Portal
    
   init(texture: SKTexture?) {
    super.init(texture: texture, color: NSColor.clear, size: (texture?.size())! )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
