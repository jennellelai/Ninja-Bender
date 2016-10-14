//
//  JLWallGenerator.swift
//  Nimble Ninja
//
//  Created by Jennelle Lai on 10/1/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import Foundation
import SpriteKit

class JLWallGenerator: SKSpriteNode {
    
    var generationTimer: Timer?
    var walls = [JLWall]()
    var wallTrackers = [JLWall]()
    
    func startGeneratingWallsEvery(seconds: TimeInterval) {
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target:self, selector: "generateWall", userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        generationTimer?.invalidate()
    }
    
    func generateWall() {
        var scale: CGFloat
        let rand = arc4random_uniform(2) //0 or 1
        if rand == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        
        let wall = JLWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (kJLGroundHeight/2 + wall.size.height/2)
        walls.append(wall)
        wallTrackers.append(wall)
        addChild(wall)
    }
    
    func stopWalls() {
        stopGenerating()
        for wall in walls {
            wall.stopMoving()
            print("stopWalls ran")
        }
    }
}
