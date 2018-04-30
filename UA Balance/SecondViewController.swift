//
//  SecondViewController.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/9/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import AVFoundation
import UIKit
import UICircularProgressRing

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var difBanner: UILabel!
    @IBOutlet weak var ordBanner: UILabel!
    @IBOutlet weak var randBanner: UILabel!
    @IBOutlet weak var difButton: UISwitch!
    @IBOutlet weak var min: UIPickerView!
    @IBOutlet weak var sec: UIPickerView!
    @IBOutlet weak var prog: UICircularProgressRingView!
    @IBOutlet weak var speed: UISlider!
    @IBOutlet weak var button: UIButton!
    var minData: [String] = [String]()
    var secData: [String] = [String]()
    let voicer = AVSpeechSynthesizer()
    var timer = Timer()
    var time = 0
    var lastTime = 0
    var running = false
    @IBOutlet weak var stopper: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.min.delegate = self
        self.sec.delegate = self
        self.min.dataSource = self
        self.sec.dataSource = self
        
        for m in 0...15 {
            minData.append(String(m))
        }
        for s in 0...59 {
            secData.append(String(s))
        }
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startCommands() {
        if let tbc = self.tabBarController as? MainTab {
            tbc.controller.state = "running"
            button.setTitle("PAUSE", for: .normal)
            button.isEnabled = true
            print("starting commands now, expect first command in one sec")
            if tbc.controller.chosenDif == 1 {
                tbc.controller.user.voice.generateOrdered()
            } else {
                tbc.controller.user.voice.generateRandom()
            }
            time = tbc.controller.chosenTime
            lastTime = time
            running = true
            runTimer()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func finishExercise() {
        if let tbc = self.tabBarController as? MainTab {
            let utterance = AVSpeechUtterance(string: tbc.controller.user.voice.outro)
            voicer.speak(utterance)
            if let tbc = self.tabBarController as? MainTab {
                let run = ["time": tbc.controller.chosenTime! - time,
                           "difficulty": tbc.controller.chosenDif!,
                           "speed": Int(speed.value)]
                tbc.controller.user.data.addDayta(dayta: run)
                tbc.controller.state = "idle"
            }
            lastTime = 0
            time = 0
            running = false
            button.setTitle("START", for: .normal)
            setupUI()
        }
    }
    
    @objc func updateTimer() {
        if let tbc = self.tabBarController as? MainTab {
            if tbc.controller.state == "intro" {
                button.setTitle(String(time), for: .normal)
                print("\(time)")
                let utterance = AVSpeechUtterance(string: String(time))
                voicer.speak(utterance)
                time -= 1
                if time < 1 {
                    timer.invalidate()
                    startCommands()
                }
            }
            else if tbc.controller.state == "running" {
                let mod = 4 * (Float(5 - tbc.controller.chosenSpeed) / 10)
                let voiceSteps = Int(4 + mod)
                let dif = time - tbc.controller.chosenTime
                let percent = Int((Double(dif) / Double(tbc.controller.chosenTime)) * Double(-100))
                let s = time % 60
                let m = (time - s) / 60
                prog.setProgress(to: CGFloat(percent), duration: 1)
                min.selectRow(minData.index(of: String(m))!, inComponent: 0, animated: true)
                sec.selectRow(secData.index(of: String(s))!, inComponent: 0, animated: true)
                print("\(time)")
                print("\(percent)")
                if (lastTime - time >= voiceSteps) {
                    let utterance = AVSpeechUtterance(string: tbc.controller.user.voice.commands[tbc.controller.user.voice.commandIndex])
                    tbc.controller.user.voice.commandIndex += 1
                    voicer.speak(utterance)
                    lastTime = time
                }
                time -= 1
                if time < 0 {
                    timer.invalidate()
                    finishExercise()
                }
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func difPressed(_ sender: UISwitch) {
        if let tbc = self.tabBarController as? MainTab {
            tbc.controller.setDif(d: difButton.isOn ? 2 : 1)
        }
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        // If user completed at least 25% of the task, record it
        if let tbc = self.tabBarController as? MainTab {
            if (Int(prog.value) > 24) {
                let run = ["time": tbc.controller.chosenTime! - time,
                           "difficulty": tbc.controller.chosenDif!,
                           "speed": Int(speed.value)]
                tbc.controller.user.data.addDayta(dayta: run)
            }
            tbc.controller.state = "idle"
        }
        lastTime = 0;
        time = 0;
        running = false
        button.setTitle("START", for: .normal)
        setupUI()
    }
    
    @IBAction func buttPressed(_ sender: UIButton) {
        if let tbc = self.tabBarController as? MainTab {
            if tbc.controller.state == "idle" {
                button.isEnabled = false
                speed.isEnabled = false
                min.isUserInteractionEnabled = false
                sec.isUserInteractionEnabled = false
                difButton.isEnabled = false
                tbc.controller.state = "intro"
                time = 3
                tbc.controller.user.voice.commandIndex = 0
                runTimer()
            }
            else if tbc.controller.state == "running" {
                button.isEnabled = true
                button.setTitle("START", for: .normal)
                tbc.controller.state = "paused"
                timer.invalidate()
                stopper.isHidden = false
                stopper.isEnabled = true
            }
            else if tbc.controller.state == "paused" {
                button.setTitle("PAUSE", for: .normal)
                tbc.controller.state = "running"
                timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
                stopper.isHidden = true
                stopper.isEnabled = false
            }
        }
    }
    @IBAction func speedSlid(_ sender: UISlider) {
        if let tbc = self.tabBarController as? MainTab {
            tbc.controller.setSpeed(s: Int(speed.value))
        }
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == min {
            return minData.count
        } else if pickerView == sec {
            return secData.count
        } else {
            return 0
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == min {
            if minData[row] == "15" {
                sec.selectRow(0, inComponent: 0, animated: true)
            }
            if min.selectedRow(inComponent: 0) < 5 && !running {
                min.selectRow(5, inComponent: 0, animated: true)
            }
            if let tbc = self.tabBarController as? MainTab {
                if !running {
                    tbc.controller.setTime(t: (Int(minData[row])! * 60) + Int(secData[sec.selectedRow(inComponent: 0)])!)
                }
            }
            return minData[row]
        } else if pickerView == sec {
            if min.selectedRow(inComponent: 0) == 15 {
                sec.selectRow(0, inComponent: 0, animated: true)
            }
            if let tbc = self.tabBarController as? MainTab {
                if !running {
                    tbc.controller.setTime(t: Int(secData[row])! + (Int(minData[min.selectedRow(inComponent: 0)])! * 60))
                }
            }
            return secData[row]
        } else {
            return "?"
        }
    }

    func setupUI() {
        if let tbc = self.tabBarController as? MainTab {
            if !running {
                let diff = (tbc.controller.user.goals["difficulty"]! - 1) == 1
                let sped = tbc.controller.user.goals["speed"]!
                let s = tbc.controller.user.goals["time"]! % 60
                let m = (tbc.controller.user.goals["time"]! - s) / 60
                difButton.setOn(diff, animated: true)
                sec.selectRow(secData.index(of: String(s))!, inComponent: 0, animated: true)
                min.selectRow(minData.index(of: String(m))!, inComponent: 0, animated: true)
                speed.setValue(Float(sped), animated: true)
                prog.setProgress(to: 0, duration: 1)
                button.isEnabled = true
                speed.isEnabled = true
                min.isUserInteractionEnabled = true
                sec.isUserInteractionEnabled = true
                difButton.isEnabled = true
                stopper.isEnabled = false
                stopper.isHidden = true
                stopper.layer.cornerRadius = 20
                stopper.clipsToBounds = true
            }
        }
    }
}

