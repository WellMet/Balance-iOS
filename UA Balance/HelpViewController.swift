//
//  HelpViewController.swift
//  UA Balance
//
//  Created by Sheldon Ruiz on 4/28/18.
//  Copyright © 2018 Sheldon Ruiz. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class HelpViewController: UIViewController {

    @IBOutlet weak var help: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        help.layer.cornerRadius = 20
        help.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func play(_ sender: UIButton) {
        guard let path = Bundle.main.path(forResource: "source", ofType:"mp4") else {
            print("source.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
