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
        objects = [String]()
        settings = [String: Int]()
        goals = [String: Int]()
        readSettings()
        voice = VoiceGeneration(settings: settings, objects: objects)
        controller = cont
        data = Dayta(goals: goals)
    }
    
    func readSettings() {
        /*
        var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("settings.json")
        do {
            let data = try Data(contentsOf: path, options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [String: Int] {
                settings = jsonResult
                print("read settings finally")
            }
        } catch {
            print("couldn't read settings")
        }
        path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("goals.json")
        do {
            let data = try Data(contentsOf: path, options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [String: Int] {
                goals = jsonResult
                print("read goals finally")
            }
        } catch {
            print("couldn't read goals")
        }
        path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("objects.json")
        do {
            let data = try Data(contentsOf: path, options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [String] {
                objects = jsonResult
                print("read objects finally")
                return true
            }
        } catch {
            print("couldn't read objects")
        }
        return false
 */

        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
        if let obj1 = UserDefaults.standard.string(forKey: "obj1") {
            objects.append(obj1)
        } else {
            objects.append("red")
        }
        if let obj2 = UserDefaults.standard.string(forKey: "obj2") {
            objects.append(obj2)
        } else {
            objects.append("blue")
        }
        if let obj3 = UserDefaults.standard.string(forKey: "obj3") {
            objects.append(obj3)
        } else {
            objects.append("green")
        }
        goals["attempts"] = UserDefaults.standard.integer(forKey: "attempts")
        goals["speed"] = UserDefaults.standard.integer(forKey: "speed")
        let m = UserDefaults.standard.integer(forKey: "minutes")
        var s = UserDefaults.standard.integer(forKey: "seconds")
        if m == 15 {
            s = 0
        }
        goals["time"] = m*60 + s
        goals["difficulty"] = UserDefaults.standard.bool(forKey: "difficulty") ? 2 : 1
        
        if goals["attempts"] == 0 {
            goals["attempts"] = 3
        }
        
        if goals["speed"] == 0 {
            goals["speed"] = 5
        }
        
        if goals["time"] == 0 {
            goals["time"] = 900
        }
        
        if goals["difficulty"] == nil {
            goals["difficulty"] = 1
        }
    }
    
    func writeSettings() {
        do {
            let sdata = try JSONEncoder().encode(settings)
            let gdata = try JSONEncoder().encode(goals)
            let odata = try JSONEncoder().encode(objects)
            
            var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("settings.json")
            try sdata.write(to: path)
            path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("goals.json")
            try gdata.write(to: path)
            path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("objects.json")
            try odata.write(to: path)
            print("we saved that shit")
        } catch {
            print("cannot save settings")
        }
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
