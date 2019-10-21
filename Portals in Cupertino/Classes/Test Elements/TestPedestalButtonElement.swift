//
//  TestPedestalButtonElement.swift
//  Portals in Cupertino
//
//  Created by Marquis Kurt on 10/18/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 A pedestal button.
 
 Pedestal buttons usually activate on a player's input and lasts for a certain amount of time before deactivating. These are usually used to create timed puzzles or to respawn items.
 */
class TestPedestalButton: TestInputElement {
    
    /**
     How long the timer lasts in seconds. Defaults to `3.0`.
     */
    var timeout: Double = 3.0
    
    static func getPedestalDirection(forButtonDefinition: SKTileDefinition) -> TestElementDirection {
        switch forButtonDefinition.rotation {
        case .rotation0:
            return .north
        case .rotation90:
            return .west
        case .rotation180:
            return .south
        case .rotation270:
            return .east
        default:
            return .unknown
        }
    }
    
    /**
     Activate the button and deactivate after the specified timeout.
     */
    func use() {
        var currentTimeout = 0.0
        self.activate()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            currentTimeout += 1.0
            if currentTimeout == self.timeout {
                self.deactivate()
                timer.invalidate()
            }
        }
    }
    
    /**
     Initialize a pedestal button.
     - Parameters:
        - timeoutAfter: The length of the timer
        - connectsTo: The type of connection
        - node: The associated `SKSpriteNode` for the button
        - antlines: The button's antlines, if any
     */
    init(timeoutAfter: Double?, connectsTo: TestInputType, node: SKSpriteNode, antlines: [Antline]?, inDirection: TestElementDirection) {
        
        if timeoutAfter != nil {
            self.timeout = timeoutAfter!
        }
        
        super.init(connectsTo: connectsTo, node: node, textureName: "Pedestal_Button", antlines: antlines)
        
        switch inDirection {
        case .west:
            self.elementNode.zRotation = .pi / 2
            break
        case .south:
            self.elementNode.zRotation = .pi
            break
        case .east:
            self.elementNode.zRotation = (3 * .pi) / 2
            break
        default:
            break
        }
        
    }
    
}
