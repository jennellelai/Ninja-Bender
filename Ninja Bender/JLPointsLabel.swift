//
//  JLPointsLabel.swift
//  Nimble Ninja
//
//  Created by Jennelle Lai on 10/2/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class JLPointsLabel: SKLabelNode {
    
    var number = 0
    
    init(num: Int) {
        super.init()
        
        fontColor = UIColor.black
        fontName = "Helvetica"
        fontSize = 24.0
        
        number = num
        text = "\(num)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment() {
        number += 1
        text = "\(number)"
        
    }
    
    func setTo(num: Int) {
        self.number = num
        text = "\(self.number)"
    }
}
