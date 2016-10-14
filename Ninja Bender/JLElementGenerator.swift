//
//  JLElementGenerator.swift
//  Ninja Bender
//
//  Created by Jennelle Lai on 10/9/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import Foundation
import SpriteKit

class JLElementGenerator: SKSpriteNode {
    
    var generationTimer: Timer?
    var elements = [JLElement]()
    var elementTrackers = [JLElement]()
    
    
    func stopGenerating() {
        generationTimer?.invalidate()
    }
    
    func generateElement(elementType: String, isUpsideDown: Bool) {
        
        let element = JLElement()
        //        element.position.x = size.width/2 + element.size/2
        //        element.position.y = scale * (kJLGroundHeight/2 + element.size/2 + 25)
        if elementType == "fire" {
            element.fillColor = UIColor.red
            element.strokeColor = UIColor.black
            
        } else if elementType == "earth" {
            element.fillColor = UIColor.green
            element.strokeColor = UIColor.black
        } else if elementType == "water" {
            element.fillColor = UIColor.blue
            element.strokeColor = UIColor.black
        }
//        else {
//            element.fillColor = UIColor.white
//            element.strokeColor = UIColor.black
//        }
        
        if (isUpsideDown) {
            element.position = CGPoint(x: -230, y: -30)
        } else {
            element.position = CGPoint(x: -230, y: 30)
        }
        
        element.zPosition = 1.0
        
        elements.append(element)
        elementTrackers.append(element)
        
        addChild(element)
    }
    
    func stopElements() {
        stopGenerating()
        for element in elements {
            element.stopMoving()
            print("stopElements ran")
        }
    }
}
