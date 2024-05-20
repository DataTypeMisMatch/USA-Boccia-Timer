//
//  ExternTechnicalTimerViewController.swift
//  USA Boccia Timer
//
//  Created by Raasikh Kanjiani on 4/13/24.
//

import Foundation
import UIKit

class ExternTeamSpecificTimerViewController: UIViewController {
    
    @IBOutlet var timerLabel: UILabel?
    @IBOutlet var blueTeamLabel: UILabel?
    @IBOutlet var redTeamLabel: UILabel?
    @IBOutlet var timerTeamLabel: UILabel?
    @IBOutlet var timerNameLabel: UILabel?
    
    var redName = "Red Team Name"
    var blueName = "Blue Team Name"
    var timerName = "Timeout"
    var teamName = "Red"

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setTimeoutTimer(_:)), name: Notification.Name("SetExternTimeoutTimer"), object: nil)
        redTeamLabel?.text = redName
        blueTeamLabel?.text = blueName
        timerTeamLabel?.text = teamName
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
