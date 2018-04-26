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
    
    init(settings: [String: Int], objects: [String]) {
        self.settings = settings
        self.objects = objects
    }
}
