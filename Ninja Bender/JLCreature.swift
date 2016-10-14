//
//  JLCreature.swift
//  Ninja Bender
//
//  Created by Jennelle Lai on 10/9/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import Foundation
import SpriteKit

class JLCreature: SKShapeNode {
    
    let size = CGFloat(10)
    let earth = UIColor.green
    let fire = UIColor.red
    let water = UIColor.blue
    
    override init() {
        super.init()
        
        
        
        self.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 10, height: 10), cornerRadius: 64).cgPath
//        shape.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let rand = arc4random_uniform(3) //0, 1, or 2
        
        if rand == 0 {
            self.fillColor = earth
            self.strokeColor = earth
            self.lineWidth = 10
        } else if rand == 1 {
            self.fillColor = fire
            self.strokeColor = fire
            self.lineWidth = 10
        } else {
            self.fillColor = water
            self.strokeColor = water
            self.lineWidth = 10
        }
        
        loadPhysicsBodyWithSize(size: size)
        startMoving()
    }
    
    func loadPhysicsBodyWithSize(size: CGFloat) {
        physicsBody = SKPhysicsBody(circleOfRadius: size, center: CGPoint(x: 0, y: 0))
        physicsBody?.categoryBitMask = creatureCategory
        //physicsBody?.contactTestBitMask = wallCategory //don't need since already set in the other physics body (hero)
        physicsBody?.affectedByGravity = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveBy(x: -kDefaultXToMovePerSecond, y: 0, duration: 1.0)
        run(SKAction.repeatForever(moveLeft))
    }
    
    func oscillate() {
        let oscillateUp = SKAction.moveBy(x: 0, y: 20, duration: 1.0)
        let oscillateDown = SKAction.moveBy(x: 0, y: -20, duration: 1.0)
        let breath = SKAction.sequence([oscillateUp, oscillateDown])
        run(SKAction.repeatForever(breath))
    }
    
    func stopMoving() {
        removeAllActions()
    }
}
