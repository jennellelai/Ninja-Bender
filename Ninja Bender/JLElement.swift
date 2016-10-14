//
//  JLElement.swift
//  Ninja Bender
//
//  Created by Jennelle Lai on 10/9/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import Foundation
import SpriteKit

class JLElement: SKShapeNode {
    
    let size = CGFloat(10)
    let earth = UIColor.green
    let fire = UIColor.red
    let water = UIColor.blue
    
    override init() {
        super.init()
  
        self.path = UIBezierPath(roundedRect: CGRect(x: -5, y: -5, width: 10, height: 10), cornerRadius: 64).cgPath

//        self.circleOfRadius = UIBezierPath(roundedRect: CGRect(x: -5, y: -5, width: 10, height: 10), cornerRadius: 64).cgPath
//        
        loadPhysicsBodyWithSize(size: size)
        startMoving()
    }
    
    func loadPhysicsBodyWithSize(size: CGFloat) {
        physicsBody = SKPhysicsBody(circleOfRadius: size, center: CGPoint(x: -5, y: -5))
        physicsBody?.categoryBitMask = elementCategory
        //physicsBody?.contactTestBitMask = wallCategory //don't need since already set in the other physics body (hero)
        physicsBody?.affectedByGravity = false
    }
    
    func startMoving() {
        let moveRight = SKAction.moveBy(x: kDefaultXToMovePerSecond, y: 0, duration: 1.0)
        run(SKAction.repeatForever(moveRight))
    }
    
    func stopMoving() {
        removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
