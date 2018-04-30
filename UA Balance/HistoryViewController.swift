//
//  HistoryViewController.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/25/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import UIKit
import UICircularProgressRing

class HistoryViewController: UIViewController {
    @IBOutlet weak var week2: UILabel!
    @IBOutlet weak var week1: UILabel!
    @IBOutlet weak var week3: UILabel!
    @IBOutlet weak var week1prog: UICircularProgressRingView!
    @IBOutlet weak var week2prog: UICircularProgressRingView!
    @IBOutlet weak var week3prog: UICircularProgressRingView!
    @IBOutlet weak var week1butt: UIButton!
    @IBOutlet weak var week2butt: UIButton!
    @IBOutlet weak var week3butt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    @IBAction func butt1Pressed(_ sender: UIButton) {
        if let tbc = self.tabBarController as? MainTab {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "blowout") as! BlowoutViewController
            let wk = week1.text?.components(separatedBy: " ")[1]
            vc.version = "hist1"
            var dataDict = [String: Int]()
            dataDict["w"] = Int(wk!)
            dataDict["overall"] = tbc.controller.user.data.getOverallProgress(week: wk!)
            dataDict["tries"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "attempts")
            dataDict["time"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "time")
            dataDict["speed"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "speed")
            dataDict["difficulty"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "difficulty")
            vc.data = dataDict
            self.present(vc, animated: true)
        }
    }
    @IBAction func butt2Pressed(_ sender: UIButton) {
        if let tbc = self.tabBarController as? MainTab {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "blowout") as! BlowoutViewController
            let wk = week1.text?.components(separatedBy: " ")[1]
            vc.version = "hist2"
            var dataDict = [String: Int]()
            dataDict["w"] = Int(wk!)
            dataDict["overall"] = tbc.controller.user.data.getOverallProgress(week: wk!)
            dataDict["tries"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "attempts")
            dataDict["time"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "time")
            dataDict["speed"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "speed")
            dataDict["difficulty"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "difficulty")
            vc.data = dataDict
            self.present(vc, animated: true)
        }
    }
    @IBAction func butt3Pressed(_ sender: UIButton) {
        if let tbc = self.tabBarController as? MainTab {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "blowout") as! BlowoutViewController
            let wk = week1.text?.components(separatedBy: " ")[1]
            vc.version = "hist3"
            var dataDict = [String: Int]()
            dataDict["w"] = Int(wk!)
            dataDict["overall"] = tbc.controller.user.data.getOverallProgress(week: wk!)
            dataDict["tries"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "attempts")
            dataDict["time"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "time")
            dataDict["speed"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "speed")
            dataDict["difficulty"] = tbc.controller.user.data.getProgressScore(week: wk!, of: "difficulty")
            vc.data = dataDict
            self.present(vc, animated: true)
        }
    }
    
    func setupUI() {
        // Get the weeks
        if let tbc = self.tabBarController as? MainTab {
            var weeks = Array(tbc.controller.user.data.history.keys)
            weeks.sort()
            var wk1 = "N/A"
            var wk2 = "N/A"
            var wk3 = "N/A"
            var prog1 = 0
            var prog2 = 0
            var prog3 = 0
            // Decide the values
            if (weeks.count >= 3) {
                wk1 = weeks[weeks.count - 1]
                wk2 = weeks[weeks.count - 2]
                wk3 = weeks[weeks.count - 3]
                prog1 = tbc.controller.user.data.getOverallProgress(week: wk1);
                prog2 = tbc.controller.user.data.getOverallProgress(week: wk2);
                prog3 = tbc.controller.user.data.getOverallProgress(week: wk3);
                week1butt.isEnabled = true
                week2butt.isEnabled = true
                week3butt.isEnabled = true
            } else if (weeks.count == 2) {
                wk1 = weeks[weeks.count - 1]
                wk2 = weeks[weeks.count - 2]
                prog1 = tbc.controller.user.data.getOverallProgress(week: wk1);
                prog2 = tbc.controller.user.data.getOverallProgress(week: wk2);
                week1butt.isEnabled = true
                week2butt.isEnabled = true
                week3butt.isEnabled = false
            } else if (weeks.count <= 1) {
                wk1 = weeks[weeks.count - 1]
                prog1 = tbc.controller.user.data.getOverallProgress(week: wk1)
                week1butt.isEnabled = true
                week2butt.isEnabled = false
                week3butt.isEnabled = false
            }
            // Set GUI
            week1.text = "Week " + wk1
            week1prog.setProgress(to: CGFloat(prog1), duration: 1)
            week2.text = "Week " + wk2
            week2prog.setProgress(to: CGFloat(prog2), duration: 2)
            week3.text = "Week " + wk3
            week3prog.setProgress(to: CGFloat(prog3), duration: 3)
            week1prog.font = UIFont.systemFont(ofSize: 36)
            week2prog.font = UIFont.systemFont(ofSize: 36)
            week3prog.font = UIFont.systemFont(ofSize: 36)
        }
    }
}
