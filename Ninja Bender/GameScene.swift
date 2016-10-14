//
//  GameScene.swift
//  Nimble Ninja
//
//  Created by Jennelle Lai on 9/28/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var fireButton = SKShapeNode(circleOfRadius:50)
    var earthButton = SKShapeNode(circleOfRadius:50)
    var waterButton = SKShapeNode(circleOfRadius:50)
    var airButton = SKShapeNode(circleOfRadius:50)
    
    var movingGround: JLMovingGround!
    
    var elements = [JLElement]()
    var elementTrackers = [JLElement]()
    var elementGenerator: JLElementGenerator!
    
    
    var hero: JLHero!
    var cloudGenerator: JLCloudGenerator!
    //    var wallGenerator: JLWallGenerator!
    var creatureGenerator: JLCreatureGenerator!
    
    var isStarted = false
    var isGameOver = false
    
    var currentLevel = 0
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        let backgroundTexture = SKTexture(imageNamed: "sun.jpg")
        let backgroundImage = SKSpriteNode(texture: backgroundTexture, size: view.frame.size)
        backgroundImage.position = view.center
        addChild(backgroundImage)
        
        fireButton.fillColor = UIColor.red
        fireButton.strokeColor = UIColor.red
        fireButton.position = CGPoint(x: view.frame.size.width - 40, y: 40)
        fireButton.zPosition = 1.0
        fireButton.setScale(0.4)
        addChild(fireButton)
        
        // Earth button.
        earthButton.fillColor = SKColor.green
        earthButton.strokeColor = SKColor.green
        earthButton.position = CGPoint(x: view.frame.size.width-90, y: 40)
        earthButton.zPosition = 1.0
        earthButton.setScale(0.4)
        self.addChild(earthButton)
        
        // Water button.
        waterButton.fillColor = SKColor.blue
        waterButton.strokeColor = SKColor.blue
        waterButton.position = CGPoint(x: view.frame.size.width-140, y: 40)
        waterButton.zPosition = 1.0
        waterButton.setScale(0.4)
        self.addChild(waterButton)
        
        // Air button.
        airButton.fillColor = SKColor.gray
        airButton.strokeColor = SKColor.gray
        airButton.position = CGPoint(x: 40, y: 40)
        airButton.zPosition = 1.0
        airButton.setScale(0.4)
        self.addChild(airButton)
        
        addMovingGround()
        addHero()
        addCloudGenerator()
        //        addWallGenerator()
        addCreatureGenerator()
        addElementGenerator()
        addTapToStartLabel()
        addPointsLabels()
        addPhysicsWorld()
        
        loadHighscore()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    
    
    func addMovingGround() {
        //let movingGround = SKSpriteNode(color: UIColor.brown, size: CGSize(width: view.frame.size.width, height: 20)) //.brown, CGSizeMake(view.frame.size.width, 20)
        
        movingGround = JLMovingGround(size: CGSize(width: view!.frame.width, height: 20))
        movingGround.position = CGPoint(x: 0, y: view!.frame.size.height/2)
        addChild(movingGround)
    }
    
    func addHero() {
        hero = JLHero()
        hero.position = CGPoint(x: 70, y: movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        hero.breathe()
    }
    
    func addCloudGenerator() {
        cloudGenerator = JLCloudGenerator(color: UIColor.clear, size: view!.frame.size)
        cloudGenerator.position = view!.center
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 7)
        cloudGenerator.startGeneratingWithSpawnTime(seconds: 5)
    }
    
    //    func addWallGenerator() {
    //        wallGenerator = JLWallGenerator(color: UIColor.clear, size: view!.frame.size)
    //        wallGenerator.position = view!.center
    //        addChild(wallGenerator)
    //    }
    
    func addCreatureGenerator() {
        creatureGenerator = JLCreatureGenerator(color: UIColor.clear, size: view!.frame.size)
        creatureGenerator.position = view!.center
        addChild(creatureGenerator)
    }
    
    func addElementGenerator() {
        elementGenerator = JLElementGenerator(color: UIColor.clear, size: view!.frame.size)
        elementGenerator.position = view!.center
        addChild(elementGenerator)
    }
    
    func addTapToStartLabel() {
        let tapToStartLabel = SKLabelNode(text: "Tap to start!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position.x = view!.center.x
        tapToStartLabel.position.y = view!.center.y + 40
        tapToStartLabel.zPosition = 1.0
        tapToStartLabel.fontName = "Helvetica"
        tapToStartLabel.fontColor = UIColor.black
        tapToStartLabel.fontSize = 22.0
        addChild(tapToStartLabel)
        tapToStartLabel.run(blinkAnimation())
    }
    
    func addPointsLabels() {
        let pointsLabel = JLPointsLabel(num: 0)
        pointsLabel.position = CGPoint(x: 20.0, y: view!.frame.size.height - 35)
        pointsLabel.name = "pointsLabel"
        addChild(pointsLabel)
        
        let highscoreLabel = JLPointsLabel(num: 0)
        highscoreLabel.position = CGPoint(x: view!.frame.size.width - 20, y: view!.frame.size.height - 35)
        highscoreLabel.name = "highscoreLabel"
        addChild(highscoreLabel)
        
        let highscoreTextLabel = SKLabelNode(text: "High")
        highscoreTextLabel.fontColor = UIColor.black
        highscoreTextLabel.fontSize = 14.0
        highscoreTextLabel.fontName = "Helvetica"
        highscoreTextLabel.position = CGPoint(x: 0, y: -20)
        highscoreLabel.addChild(highscoreTextLabel)
        
    }
    
    func addPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }
    
    func loadHighscore() {
        let defaults = UserDefaults.standard
        
        let highscoreLabel = childNode(withName: "highscoreLabel") as! JLPointsLabel
        highscoreLabel.setTo(num: defaults.integer(forKey: "highscore"))
    }
    
    //MARK: - Game Lifecycle
    func start() {
        isStarted = true
        
        let tapToStartLabel = childNode(withName: "tapToStartLabel")
        tapToStartLabel?.removeFromParent()
        
        hero.stop()
        hero.startRunning()
        movingGround.start()
        //        wallGenerator.startGeneratingWallsEvery(seconds: 5)
        creatureGenerator.startGeneratingCreaturesEvery(seconds: 3)
    }
    
    func gameOver() {
        isGameOver = true
        
        //stop everything
        hero.fall()
        //        wallGenerator.stopWalls()
        creatureGenerator.stopCreatures()
        elementGenerator.stopElements()
        movingGround.stop()
        hero.stop()
        
        //create game over label
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.fontColor = UIColor.black
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.position.x = view!.center.x
        gameOverLabel.position.y = view!.center.y + 40
        gameOverLabel.fontSize = 22.0
        addChild(gameOverLabel)
        gameOverLabel.run(blinkAnimation())
        
        //save current points label value
        let pointsLabel = childNode(withName: "pointsLabel") as! JLPointsLabel
        let highscoreLabel = childNode(withName: "highscoreLabel") as! JLPointsLabel
        
        if highscoreLabel.number < pointsLabel.number {
            highscoreLabel.setTo(num: pointsLabel.number)
            
            let defaults = UserDefaults.standard
            defaults.set(highscoreLabel.number, forKey: "highscore")
            
        }
    }
    
    
    
    func restart() {
        cloudGenerator.stopGenerating()
        
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .aspectFill
        
        view!.presentScene(newScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isGameOver {
            restart()
        } else if !isStarted {
            start()
            print("start")
        } else {
            for touch: AnyObject in touches {
                let location = (touch as! UITouch).location(in: self)
                if fireButton.contains(location){
                    print("fire ran")
                    elementGenerator.generateElement(elementType: "fire", isUpsideDown: hero.isUpsideDownStatus())
                    
                } else if earthButton.contains(location) {
                        print("earth ran")
                    elementGenerator.generateElement(elementType: "earth", isUpsideDown: hero.isUpsideDownStatus())
                } else if waterButton.contains(location) {
                    print("water ran")
                    elementGenerator.generateElement(elementType: "water", isUpsideDown: hero.isUpsideDownStatus())
                    
                } else if airButton.contains(location) {
                    print("air ran")
                    hero.flip()
                    
                } else {
                    
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //        if wallGenerator.wallTrackers.count > 0 {
        //
        //            let wall = wallGenerator.wallTrackers[0] as JLWall
        //            let wallLocation = self.view?.convert(wall.position, to: self)
        //            if (wallLocation?.x)! < hero.position.x {
        //                wallGenerator.wallTrackers.remove(at: 0)
        //                let pointsLabel = childNode(withName: "pointsLabel") as! JLPointsLabel
        //                pointsLabel.increment()
        //
        //                //if pointsLabel.number % kNumberOfPointsPerLevel == 0 {
        //                if currentLevel < kLevelGenerationTimes.count - 1 {
        //                    currentLevel += 1
        //                    wallGenerator.stopGenerating()
        //                    wallGenerator.startGeneratingWallsEvery(seconds: kLevelGenerationTimes[currentLevel])
        //                }
        //
        //            }
        //        }
    }
    
    //MARK: - SKPhysicsContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        if !isGameOver {
            gameOver()
        }
        
    }
    
    func blinkAnimation() -> SKAction {
        let duration = 0.4
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(blink)
    }
    
}
