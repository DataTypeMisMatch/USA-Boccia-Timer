//
//  ExternWinnerViewController.swift
//  USA Boccia Timer
//
//  Created by Raasikh Kanjiani on 4/15/24.
//

import Foundation
import UIKit

class ExternWinnerViewController: UIViewController {
    
    @IBOutlet var redLabel: UILabel?
    @IBOutlet var blueLabel: UILabel?
    @IBOutlet var redScoreLabel: UILabel?
    @IBOutlet var blueScoreLabel: UILabel?
    @IBOutlet var redLaurelWreathImage: UIImageView?
    @IBOutlet var blueLaurelWreathImage: UIImageView?
    var redName = "Red Team Name"
    var blueName = "Blue Team Name"
    var redScore = "0"
    var blueScore = "0"
    var winner = "red"
   
    override func viewDidLoad() {
        redLabel?.text = redName
        blueLabel?.text = blueName
        redScoreLabel?.text = redScore
        blueScoreLabel?.text = blueScore
        
        // POSSIBLY AUTOMATE THIS BASED ON GIVEN SCORE
        if winner.lowercased() == "red" {
            redLaurelWreathImage?.isHidden = false // show red
            blueLaurelWreathImage?.isHidden = true // hide blue
        } else {
            redLaurelWreathImage?.isHidden = true // hide red
            blueLaurelWreathImage?.isHidden = false // show blue
        }
    }
}
