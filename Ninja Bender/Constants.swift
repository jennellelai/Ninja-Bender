//
//  Constants.swift
//  Nimble Ninja
//
//  Created by Jennelle Lai on 10/1/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import Foundation
import UIKit

//Configuration
let kJLGroundHeight: CGFloat = 20.0

//Initial Variables
let kDefaultXToMovePerSecond: CGFloat = 320.0

//Collision Detection
let heroCategory: UInt32 = 0x1 << 0
let wallCategory: UInt32 = 0x1 << 1
let creatureCategory: UInt32 = 0x1 << 2
let elementCategory: UInt32 = 0x1 << 3

// Game variables
let kNumberOfPointsPerLevel = 4
let kLevelGenerationTimes: [TimeInterval] = [1.0, 0.8, 0.6, 0.4]
