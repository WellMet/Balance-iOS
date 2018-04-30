//
//  FirstViewController.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/9/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import UIKit
import UICircularProgressRing
import UserNotifications

class FirstViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var weekBanner: UILabel!
    @IBOutlet weak var progress: UICircularProgressRingView!
    @IBOutlet weak var curProg: UIButton!
    @IBOutlet weak var play: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: 12, minute: 0, weekday: 2), repeats: true)
        print(trigger.nextTriggerDate() ?? "nil")
        
        let content = UNMutableNotificationContent()
        content.title = "Come Practice!"
        content.body = "Time to practice your balance!"
        // make sure you give each request a unique identifier. (nextTriggerDate description)
        let request = UNNotificationRequest(identifier: "identify", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
                return
            }
            print("scheduled")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func progPressed(_ sender: UIButton) {
        if let tbc = self.tabBarController as? MainTab {
            tbc.selectedIndex = 2
        }
    }

    @IBAction func playPressed(_ sender: UIButton) {
        if let tbc = self.tabBarController as? MainTab {
            tbc.selectedIndex = 1
        }
    }
    
    func setupUI() {
        // Set the week number to the latest week in data
        if let tbc = self.tabBarController as? MainTab {
            let keys = Array(tbc.controller.user.data.history.keys)
            weekBanner.text = "Week " + keys.last!
            let curPerc = tbc.controller.user.data.getOverallProgress(week: keys.last!)
            progress.setProgress(to: 0, duration: 0)
            progress.setProgress(to: CGFloat(curPerc), duration: 1) {
                print("setting progress to \(curPerc)")
            }
            progress.font = UIFont.systemFont(ofSize: 36)
            play.layer.cornerRadius = 20
            play.clipsToBounds = true
        }
    }
}

