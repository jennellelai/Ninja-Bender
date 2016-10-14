//
//  JLHero.swift
//  Nimble Ninja
//
//  Created by Jennelle Lai on 9/30/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class JLHero: SKSpriteNode {
    
    var body: SKSpriteNode!
    var arm: SKSpriteNode!
    var leftFoot: SKSpriteNode!
    var rightFoot: SKSpriteNode!
    

    var isUpsideDown = false
    
    
    
//    var elements = [JLElement]()
//    var elementTrackers = [JLElement]()
    
    
    
    init() {
        
        let size = CGSize(width: 32, height: 44)
        
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        loadAppearance()
        loadPhysicsBodyWithSize(size: size)
        
        
    }
    
    func loadAppearance() {
        body = SKSpriteNode(color: UIColor.black, size: CGSize(width: 32, height: 40))
        body.position = CGPoint(x: 0, y: 2)
        body.zPosition = 1.0
        addChild(body)
        
        let skinColor = UIColor(red: 207.0/255.0, green: 193.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        let face = SKSpriteNode(color: skinColor, size: CGSize(width: self.frame.size.width, height: 12))
        face.position = CGPoint(x: 0, y: 6)
        body.addChild(face)
        
        let eyeColor = UIColor.white
        let leftEye = SKSpriteNode(color: eyeColor, size: CGSize(width: 6, height: 6))
        let rightEye = leftEye.copy() as! SKSpriteNode
        let pupil = SKSpriteNode(color: UIColor.black, size: CGSize(width: 3, height: 3))
        
        pupil.position = CGPoint(x: 2, y: 0)
        leftEye.addChild(pupil)
        rightEye.addChild(pupil.copy() as! SKSpriteNode)
        
        leftEye.position = CGPoint(x: -4, y: 0)
        face.addChild(leftEye)
        
        rightEye.position = CGPoint(x: 14, y: 0)
        face.addChild(rightEye)
        
        let eyebrow = SKSpriteNode(color: UIColor.black, size: CGSize(width: 11, height: 1))
        eyebrow.position = CGPoint(x: -1, y: leftEye.size.height/2)
        leftEye.addChild(eyebrow)
        rightEye.addChild(eyebrow.copy() as! SKSpriteNode)
        
        let armColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0);
        arm = SKSpriteNode(color: armColor, size: CGSize(width: 8, height: 14))
        arm.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        arm.position = CGPoint(x: -10, y: -7)
        body.addChild(arm)
        
        let hand = SKSpriteNode(color: skinColor, size: CGSize(width: arm.size.width, height: 5))
        hand.position = CGPoint(x: 0, y: -arm.size.height*0.9 + hand.size.height/2)
        arm.addChild(hand)
        
        leftFoot = SKSpriteNode(color: UIColor.black, size: CGSize( width: 9, height: 4))
        leftFoot.position = CGPoint(x: -6, y: -size.height/2 + leftFoot.size.height/2)
        leftFoot?.zPosition = 1.0
        addChild(leftFoot)
        
        rightFoot = leftFoot.copy() as! SKSpriteNode
        rightFoot.position.x = 0
        rightFoot?.zPosition = 1.0
        addChild(rightFoot)
    }
    
    //PhysicsBody for detecting collisions between physics bodies
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = heroCategory
        physicsBody?.contactTestBitMask = wallCategory
        physicsBody?.contactTestBitMask = creatureCategory
//        physicsBody?.contactTestBitMask = elementCategory
        physicsBody?.affectedByGravity = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func isUpsideDownStatus() -> Bool {
        return isUpsideDown
    }
    
    
    func flip() {
        isUpsideDown = !isUpsideDown
        
        var scale: CGFloat!
        if isUpsideDown {
            scale = -1.0
        } else {
            scale = 1.0
        }
        let translate = SKAction.moveBy(x: 0, y: scale*(size.height + kJLGroundHeight), duration: 0.05)
        let flip = SKAction.scaleY(to: scale, duration: 0.05)
        
        run(translate)
        run(flip)
    }
    
    func fall() {
        physicsBody?.affectedByGravity = true
        physicsBody?.applyImpulse(CGVector(dx: -5, dy: 30));
        
        let rotateBack = SKAction.rotate(byAngle: CGFloat(M_PI)/2, duration: 0.4)
        run(rotateBack)
    }
    
    func breathe() {
        let breatheOut = SKAction.moveBy(x: 0, y: -2, duration: 1)
        let breatheIn = SKAction.moveBy(x: 0, y: 2, duration: 1)
        let breath = SKAction.sequence([breatheOut, breatheIn])
        body.run(SKAction.repeatForever(breath))
    }
    
    func startRunning() {
        let rotateBack = SKAction.rotate( byAngle: CGFloat(M_PI)/2.0, duration: 0.1)
        arm.run(rotateBack)
        
        performOneRunCycle()
    }
    
    func performOneRunCycle() {
        let up = SKAction.moveBy(x: 0, y: 2, duration: 0.05)
        let down = SKAction.moveBy(x: 0, y: -2, duration: 0.05)
        
        leftFoot.run(up, completion: { () -> Void in
            self.leftFoot.run(down)
            self.rightFoot.run(up, completion: { () -> Void in
                self.rightFoot.run(down, completion: { () -> Void in
                    self.performOneRunCycle()
                })
            })
        })
    }
    
    func stop() {
        body.removeAllActions()
        leftFoot.removeAllActions()
        rightFoot.removeAllActions()
    }
    
    
    
//    func shoot(elementType: String) -> Void {
//        print("shootElement ran")
//        
//        let elementX = 70
//        let elementY = -7
//        
//        let element = JLElement()
//        //        element.position.x = size.width/2 + element.size/2
//        //        element.position.y = scale * (kJLGroundHeight/2 + element.size/2 + 25)
//        
//        if elementType == "fire" {
//            element.fillColor = UIColor.red
//            element.strokeColor = UIColor.black
//        } else if elementType == "water" {
//            element.fillColor = UIColor.blue
//            element.strokeColor = UIColor.black
//        } else {
//            element.fillColor = UIColor.green
//            element.strokeColor = UIColor.black
//        }
//        
//        element.position = CGPoint(x: elementX + 50, y: elementY)
//        element.zPosition = 1.0
//        elements.append(element)
//        elementTrackers.append(element)
//        addChild(element)
//    }
    
    
}
