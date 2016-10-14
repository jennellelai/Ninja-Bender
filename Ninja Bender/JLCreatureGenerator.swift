//
//  JLCreatureGenerator.swift
//  Ninja Bender
//
//  Created by Jennelle Lai on 10/9/16.
//  Copyright © 2016 JenL. All rights reserved.
//


import Foundation
import SpriteKit

class JLCreatureGenerator: SKSpriteNode {
    
    var generationTimer: Timer?
    var creatures = [JLCreature]()
    var creatureTrackers = [JLCreature]()
    
    func startGeneratingCreaturesEvery(seconds: TimeInterval) {
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target:self, selector: "generateCreature", userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        generationTimer?.invalidate()
    }
    
    func generateCreature() {
        var scale: CGFloat
        let rand = arc4random_uniform(2) //0 or 1
        if rand == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        
        let creature = JLCreature()
        creature.position.x = size.width/2 + creature.size/2
        creature.position.y = scale * (20)
        creatures.append(creature)
        creatureTrackers.append(creature)
        addChild(creature)
        creature.oscillate()
    }
    
    func stopCreatures() {
        stopGenerating()
        for creature in creatures {
            creature.stopMoving()
            print("stopCreatures ran")
        }
    }
}
