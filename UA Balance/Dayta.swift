//
//  Dayta.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/24/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import Foundation

class Dayta: Codable {
    var history: [String: [[String: Int]]]!
    var goals: [String: Int]!
    
    init(goals: [String: Int]) {
        if (!readData()) {
            history = [String: [[String: Int]]]()
            let calendar = Calendar.current
            let weekOfYear = calendar.component(.weekOfYear, from: Date())
            let init_runs = [[String: Int]]()
            history[String(weekOfYear)] = init_runs
        }
        self.goals = goals
    }
    
    func writeData() {
        
    }
    
    func readData() -> Bool {
        return false
    }
    
    func getOverallProgress(week: String) -> Int {
        // Sum the weighted average of all the categories
        let speedScore = getProgressScore(week: week, of: "speed")
        let difScore = getProgressScore(week: week, of: "difficulty")
        let timeScore = getProgressScore(week: week, of: "time")
        let attemptScore = getProgressScore(week: week, of: "attempts")
        
        return Int(speedScore + difScore + timeScore + attemptScore)
    }
    
    func getProgressScore(week: String, of: String) -> Int {
        let attempts = history[week]
        var score: Double = 0
        if (of == "attempts") {
            score = Double(attempts!.count / goals["attempts"]!)
            return Int(((score * Profile.RUN_WEIGHT) * 100))
        }
        else if (of == "speed"){
            score = getAverageOf(week: week, of: of) / Double(goals["speed"]!)
            return Int((score * Profile.SPEED_WEIGHT) * 100)
        }
        else if (of == "difficulty") {
            score = getAverageOf(week: week, of: of) / Double(goals["difficulty"]!)
            return Int((score * Profile.DIF_WEIGHT) * 100);
        }
        else if (of == "time") {
            score = getAverageOf(week: week, of: of) / Double(goals["time"]!)
            return Int((score * Profile.TIME_WEIGHT) * 100);
        }
        else {
            return 0
        }
    }

    func getAverageOf(week: String, of: String) -> Double {
        var sum: Double = 0
        if (history[week]!.count > 0) {
            for attempt in history[week]! {
                sum += Double(attempt[of]!)
            }
        }
        return sum
    }
}
