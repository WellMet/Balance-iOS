//
//  Controller.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/24/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import Foundation

class Controller: Codable {
    var user: Profile!
    var state: String!
    var chosenDif: Int!
    var chosenSpeed: Int!
    var chosenTime: Int!
    
    init() {
        chosenDif = 1
        chosenSpeed = 5
        chosenTime = 900
        state = "idle"
        user = Profile(cont: self)
    }
    
    func setSpeed(s: Int) {
        chosenSpeed = s
        user.voice.chosenSpeed = s
    }
    
    func setTime(t: Int) {
        chosenTime = t
        user.voice.chosenTime = t
    }
    
    func setDif(d: Int) {
        chosenDif = d
        if d == 1 {
            user.voice.generateOrdered()
        } else {
            user.voice.generateRandom()
        }
    }
}
