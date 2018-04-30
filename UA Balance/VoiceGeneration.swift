//
//  VoiceGeneration.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/24/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import Foundation

class VoiceGeneration: Codable {
    var settings: [String: Int]
    var objects: [String]
    var intro: [String]
    let outro: String = "Well Done!"
    var commands: [String]
    var commandIndex: Int
    var chosenSpeed: Int
    var chosenTime: Int
    
    let COMMAND_DURATION: Int = 4 // 4 second default command duration
    
    init(settings: [String: Int], objects: [String]) {
        self.settings = settings
        self.objects = objects
        intro = [String]()
        commands = [String]()
        intro.append("3")
        intro.append("2")
        intro.append("1")
        commandIndex = 0
        chosenTime = 900
        chosenSpeed = 5
    }
    
    func generateOrdered() {
        // Function maps chosen speed (1 - 10) to a multiplier (0.5 - 1.5)
        commands.removeAll()
        let directions = ["Left", "Right"]
        var directionIndex = false;
        var objectIndex = 0;
        
        var tmpObjs = objects
        // Add the downward trend
        for obj in objects.reversed() {
            tmpObjs.append(obj)
        }
        
        // Generate the commands: direction + object 1,2,3,3,2,1; other_direction + object 1,2,3,3,2,1
        for _ in 0...450 {
            commands.append(directions[directionIndex ? 1 : 0] + " foot, " + tmpObjs[objectIndex])
            if (objectIndex == tmpObjs.count - 1) {
                objectIndex = 0
                directionIndex = !directionIndex
            }
            else {
                objectIndex += 1
            }
        }
    }
    
    func generateRandom() {
        commands.removeAll()
        let directions = ["Left", "Right"]
        var objectIndex = 0
        var directionIndex = 0
        
        for _ in 0...450 {
            objectIndex = Int(arc4random_uniform(UInt32(objects.count)))
            directionIndex = Int(arc4random_uniform(2))
            commands.append(directions[directionIndex] + " foot, " + objects[objectIndex])
        }
    }
}
