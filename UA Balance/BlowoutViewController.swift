//
//  BlowoutViewController.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/27/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import UIKit
import UICircularProgressRing

class BlowoutViewController: UIViewController {
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var prog: UICircularProgressRingView!
    @IBOutlet weak var exit: UIButton!
    @IBOutlet weak var tries: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var dif: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var triesprog: UIProgressView!
    @IBOutlet weak var timeprog: UIProgressView!
    @IBOutlet weak var difprog: UIProgressView!
    @IBOutlet weak var speedprog: UIProgressView!
    var version = "hist1"
    var data = [String: Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("what")
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func exitPls(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("closing")
        }
    }
    
    func setupUI() {
        if version == "hist1" {
            week.textColor = UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0) /* #ff4081 */

            
            prog.fontColor = UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0) /* #ff4081 */
            prog.innerRingColor = UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0) /* #ff4081 */
            prog.outerRingColor = UIColor(red: 255/255, green: 179/255, blue: 213/255, alpha: 1.0) /* #ffb3d5 */
            triesprog.progressTintColor = UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0) /* #ff4081 */
            timeprog.progressTintColor = UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0) /* #ff4081 */
            difprog.progressTintColor = UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0) /* #ff4081 */
            speedprog.progressTintColor = UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0) /* #ff4081 */
        }
        else if version == "hist2" {
            week.textColor = UIColor(red: 0/255, green: 161/255, blue: 116/255, alpha: 1.0) /* #00a174 */

            
            prog.fontColor = UIColor(red: 0/255, green: 161/255, blue: 116/255, alpha: 1.0) /* #00a174 */
            prog.innerRingColor = UIColor(red: 0/255, green: 161/255, blue: 116/255, alpha: 1.0) /* #00a174 */
            prog.outerRingColor = UIColor(red: 187/255, green: 224/255, blue: 212/255, alpha: 1.0) /* #bbe0d4 */
            triesprog.progressTintColor = UIColor(red: 0/255, green: 161/255, blue: 116/255, alpha: 1.0) /* #00a174 */
            timeprog.progressTintColor = UIColor(red: 0/255, green: 161/255, blue: 116/255, alpha: 1.0) /* #00a174 */
            difprog.progressTintColor = UIColor(red: 0/255, green: 161/255, blue: 116/255, alpha: 1.0) /* #00a174 */
            speedprog.progressTintColor = UIColor(red: 0/255, green: 161/255, blue: 116/255, alpha: 1.0) /* #00a174 */
        }
        else if version == "hist3" {
            week.textColor = UIColor(red: 234/255, green: 84/255, blue: 0/255, alpha: 1.0) /* #ea5400 */

            
            prog.fontColor = UIColor(red: 234/255, green: 84/255, blue: 0/255, alpha: 1.0) /* #ea5400 */
            prog.innerRingColor = UIColor(red: 234/255, green: 84/255, blue: 0/255, alpha: 1.0) /* #ea5400 */
            prog.outerRingColor = UIColor(red: 242/255, green: 205/255, blue: 180/255, alpha: 1.0) /* #f2cdb4 */
            triesprog.progressTintColor = UIColor(red: 234/255, green: 84/255, blue: 0/255, alpha: 1.0) /* #ea5400 */
            timeprog.progressTintColor = UIColor(red: 234/255, green: 84/255, blue: 0/255, alpha: 1.0) /* #ea5400 */
            difprog.progressTintColor = UIColor(red: 234/255, green: 84/255, blue: 0/255, alpha: 1.0) /* #ea5400 */
            speedprog.progressTintColor = UIColor(red: 234/255, green: 84/255, blue: 0/255, alpha: 1.0) /* #ea5400 */
        }
        prog.setProgress(to: CGFloat(data["overall"]!), duration: 1)
        week.text = "Week " + String(data["w"]!)
        triesprog.setProgress(Float(data["tries"]!) / 50.0, animated: true)
        timeprog.setProgress(Float(data["time"]!) / 25.0, animated: true)
        difprog.setProgress(Float(data["difficulty"]!) / 10.0, animated: true)
        speedprog.setProgress(Float(data["speed"]!) / 15.0, animated: true)
        
    }
}
