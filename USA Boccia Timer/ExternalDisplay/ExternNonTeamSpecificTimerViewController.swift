//
//  ExternWarmupTimerViewController.swift
//  USA Boccia Timer
//
//  Created by Raasikh Kanjiani on 4/12/24.
//

import Foundation
import UIKit

class ExternNonTeamSpecificTimerViewController: UIViewController {
    
    @IBOutlet var timerLabel: UILabel?
    @IBOutlet var blueLabel: UILabel?
    @IBOutlet var redLabel: UILabel?
    @IBOutlet var timerNameLabel: UILabel?
    var redName = "Red Team Name"
    var blueName = "Blue Team Name"
    var timerName = "Timeout"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setTimeoutTimer(_:)), name: Notification.Name("SetExternTimeoutTimer"), object: nil)
        redLabel?.text = redName
        blueLabel?.text = blueName
        timerNameLabel?.text = timerName
    }
    
    @objc func setTimeoutTimer(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let newTime = userInfo["message"] as? String {
                timerLabel?.text = newTime
            }
        }
    }
    
    deinit {
        // Remove observer when view controller is deallocated
        NotificationCenter.default.removeObserver(self)
    }
}
