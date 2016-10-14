//
//  JLCloudGenerator.swift
//  Nimble Ninja
//
//  Created by Jennelle Lai on 10/1/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import Foundation
import SpriteKit

class JLCloudGenerator: SKSpriteNode {
    
    let CLOUD_WIDTH: CGFloat = 125.0
    let CLOUD_HEIGHT: CGFloat = 55.0
    
    var generationTime: Timer!
    
    func populate(num: Int) {
        for i in 0...num {
            let cloud = JLCloud(size: CGSize(width: CLOUD_WIDTH, height: CLOUD_HEIGHT))
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2 //value from 0 and the width of our screen - (so that clouds are contained within the view)
            let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
            cloud.position = CGPoint(x: x, y: y)
            addChild(cloud)
        }
    }
    
    func startGeneratingWithSpawnTime(seconds: TimeInterval) {
        generationTime = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: "generateCloud", userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        generationTime.invalidate()
    }
    
    func generateCloud() {
        let x = size.width/2 + CLOUD_WIDTH/2
        let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
        let cloud = JLCloud(size: CGSize(width: CLOUD_WIDTH, height: CLOUD_HEIGHT))
        cloud.position = CGPoint(x: x, y: y)
        addChild(cloud)
    }
    
}
