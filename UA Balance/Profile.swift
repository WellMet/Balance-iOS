//
//  Profile.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/24/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import Foundation

class Profile: Codable {
    var data: Dayta!
    var voice: VoiceGeneration!
    var controller: Controller!
    var goals: [String: Int]!
    var settings: [String: Int]!
    var objects: [String]!
    static let RUN_WEIGHT = 0.50
    static let TIME_WEIGHT = 0.25
    static let SPEED_WEIGHT = 0.15
    static let DIF_WEIGHT = 0.10
    
    init (cont: Controller) {
        if (!readSettings()) {
            //settings["textSize"] = 32
            objects = [String]()
            settings = [String: Int]()
            goals = [String: Int]()
            
            objects.append("green");
            objects.append("blue");
            objects.append("red");
            //settings["volume"] = maxVolume
            //settings.put("brightness", 255);
            //settings.put("maxVolume", maxVolume);
            goals["attempts"] = 3
            goals["difficulty"] = 1
            goals["speed"] = 5
            goals["time"] = 900
        }
        voice = VoiceGeneration(settings: settings, objects: objects)
        controller = cont
        data = Dayta(goals: goals)
    }
    
    func writeSettings() {

    }
    
    func readSettings() -> Bool {
        
        return false
    }
    
    func setGoals(goals: Dictionary<String, Int>) {
        self.goals = goals;
        self.data.goals = goals
        writeSettings();
    }
    
    func setFontSize(size: Int) {
        // Convert from seekbar to dp
        //if (size > 20)
        //settings.put("textSize", 20 + 15);
        //else
        //settings.put("textSize", size + 15);
        writeSettings();
    }
    
    func setObject(s: String, index: Int) {
        objects[index] = s
        writeSettings()
    }
    
    /*
    public void setVolume(int v) {
        if (v > (int)settings.get("maxVolume"))
        settings.put("volume", (int) settings.get("maxVolume"));
        else
        settings.put("volume", v);
        writeSettings();
    }
    
    public void setBrightness(int b) {
        settings.put("brightness", b);
        writeSettings();
    }
     */
    
    func setGoal(s: String, i: Int) {
        goals[s] = i
        data.goals[s] = i
        writeSettings();
    }
}
