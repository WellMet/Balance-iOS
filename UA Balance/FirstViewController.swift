//
//  FirstViewController.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/9/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import UIKit
import UICircularProgressRing

class FirstViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var weekBanner: UILabel!
    @IBOutlet weak var progress: UICircularProgressRingView!
    @IBOutlet weak var curProg: UIButton!
    @IBOutlet weak var play: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the UI
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
            progress.setProgress(to: CGFloat(curPerc), duration: 1) {
                print("setting progress to \(curPerc)")
            }
            progress.font = UIFont.systemFont(ofSize: 36)
            play.layer.cornerRadius = 20
            play.clipsToBounds = true
        }
    }
}

