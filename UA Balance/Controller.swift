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
}
