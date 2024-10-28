//
//  InputScoreViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/24/24.
//

import Foundation
import UIKit

protocol InputScoreViewControllerDelegate: AnyObject
{
   func inputScoreViewControllerDidCancel(
      _ controller: InputScoreViewController)
   
   func inputScoreViewController(
      _ controller: InputScoreViewController,
      didFinishAdding item: EndsItem)
}

class InputScoreViewController: UIViewController
{
   
   var newMatchItem = MatchItem()
   var endsItem = [EndsItem]()
   
   var currentEndItem = EndsItem()
   
   var currentEndNumber = 0
   var currentEndTitle = ""
   
   var currentTimeRedTeamEnd = 0
   var currentTimeBlueTeamEnd = 0
   
   var redTeamCumulativeScore = 0
   var blueTeamCumulativeScore = 0
   
   var needsTieBreak = false
   
   weak var delegate: InputScoreViewControllerDelegate?
   
   
   @IBOutlet weak var endsButton: UIButton!
   @IBOutlet weak var redTeamNameLabel: UILabel!
   @IBOutlet weak var redTeamFlagImage: UIImageView!
   @IBOutlet weak var redTeamTimeRemainingLabel: UILabel!
   @IBOutlet weak var redTeamTimeRemainingStepper: UIStepper!
   @IBOutlet weak var redTeamBallsScored: UISegmentedControl!
   @IBOutlet weak var redTeamPenaltiesScored: UISegmentedControl!
   @IBOutlet weak var blueTeamNameLabel: UILabel!
   @IBOutlet weak var blueTeamFlagImage: UIImageView!
   @IBOutlet weak var blueTeamTimeRemainingLabel: UILabel!
   @IBOutlet weak var blueTeamTimeRemainingStepper: UIStepper!
   @IBOutlet weak var blueTeamBallsScored: UISegmentedControl!
   @IBOutlet weak var blueTeamPenaltiesScored: UISegmentedControl!

   @IBOutlet weak var redTeamView: UIView!
   @IBOutlet weak var blueTeamView: UIView!
   @IBOutlet weak var headerView: UIView!
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      
      //Set Maximum Values in the Steppers to prevent a subtle bug
      redTeamTimeRemainingStepper.maximumValue = Double(newMatchItem.endsTime)
      blueTeamTimeRemainingStepper.maximumValue = Double(newMatchItem.endsTime)
      
      //endsButton.showsMenuAsPrimaryAction = true
      //endsButton.menu = addMenuItems()
      //endsButton.setTitle(currentEndNumber.description, for: .normal)
      
      endsButton.setTitle(currentEndTitle, for: .normal)
      
      endsButton.titleLabel?.font = UIFont.systemFont(ofSize: 55)
      
      redTeamNameLabel.text = newMatchItem.redTeamName
      redTeamFlagImage.image = UIImage(named: newMatchItem.redTeamFlagName)
      redTeamTimeRemainingLabel.text = formatTimerMinutesSeconds(currentTimeRedTeamEnd)
      redTeamTimeRemainingStepper.value = Double(currentTimeRedTeamEnd)
      
      blueTeamNameLabel.text = newMatchItem.blueTeamName
      blueTeamFlagImage.image = UIImage(named: newMatchItem.blueTeamFlagName)
      blueTeamTimeRemainingLabel.text = formatTimerMinutesSeconds(currentTimeBlueTeamEnd)
      blueTeamTimeRemainingStepper.value = Double(currentTimeBlueTeamEnd)
      
      //Round Corners of the CountDown Timer and Penalty Labels, and their respective Buttons
      blueTeamTimeRemainingLabel.layer.masksToBounds = true
      blueTeamTimeRemainingLabel.layer.borderWidth = 2
      blueTeamTimeRemainingLabel.layer.cornerRadius = 15
      blueTeamTimeRemainingLabel.layer.borderColor = UIColor.black.cgColor
      
      redTeamTimeRemainingLabel.layer.masksToBounds = true
      redTeamTimeRemainingLabel.layer.borderWidth = 2
      redTeamTimeRemainingLabel.layer.cornerRadius = 15
      redTeamTimeRemainingLabel.layer.borderColor = UIColor.black.cgColor
      
      //Round Corners and Set Border of the Red and Blue Team Containers
      blueTeamView.layer.masksToBounds = true
      blueTeamView.layer.borderWidth = 4
      blueTeamView.layer.cornerRadius = 15
      blueTeamView.layer.borderColor = UIColor.blue.cgColor
      
      redTeamView.layer.masksToBounds = true
      redTeamView.layer.borderWidth = 4
      redTeamView.layer.cornerRadius = 15
      redTeamView.layer.borderColor = UIColor.red.cgColor
      
      //Round Corners of the CountDown Timer and Penalty Labels, and their respective Buttons
      endsButton.layer.masksToBounds = true
      endsButton.layer.cornerRadius = 15
   }
   
   
   //MARK:  - Actions
   
   @IBAction func cancel()
   {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func done()
   {
      
      //Save Data into Array
      currentEndItem.endNumber = currentEndNumber
      currentEndItem.classification = newMatchItem.classification
      currentEndItem.endsTime = newMatchItem.endsTime
      currentEndItem.redTeamName = newMatchItem.redTeamName
      currentEndItem.blueTeamName = newMatchItem.blueTeamName
      currentEndItem.redTeamFlagName = newMatchItem.redTeamFlagName
      currentEndItem.blueTeamFlagName = newMatchItem.blueTeamFlagName
      currentEndItem.redTeamFinalScore = redTeamBallsScored.selectedSegmentIndex
      currentEndItem.blueTeamFinalScore = blueTeamBallsScored.selectedSegmentIndex
      currentEndItem.redTeamPenaltiesScored = redTeamPenaltiesScored.selectedSegmentIndex
      currentEndItem.blueTeamPenaltiesScored = blueTeamPenaltiesScored.selectedSegmentIndex
      currentEndItem.redTeamPenaltyCount = 0
      currentEndItem.blueTeamPenaltyCount = 0
      
      currentEndItem.blueTeamEndTimeRemaining = currentTimeBlueTeamEnd
      currentEndItem.redTeamEndTimeRemaining = currentTimeRedTeamEnd
   
      
      //Check if Last Ends or Needs TieBreak
      if (needsTieBreak)
      {
	 currentEndNumber += 1
	 needsTieBreak = false
      }
      else if ( currentEndNumber >= newMatchItem.numEnds )
      {
	 //Game Over
	 let item = currentEndItem
	 delegate?.inputScoreViewController(self, didFinishAdding: item)
      }
      else
      {
	 currentEndNumber += 1
	 
	 let item = currentEndItem
	 delegate?.inputScoreViewController(self, didFinishAdding: item)
      }
       
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("ClearScoreboard"), object: nil, userInfo: ["message": ""])
   }
   
   
   @IBAction func redTeamEndTimeStepperChanged(_ sender: UIStepper)
   {
      currentTimeRedTeamEnd = Int( sender.value )
      redTeamTimeRemainingLabel.text = formatTimerMinutesSeconds( Int(sender.value) )
   }
   
   @IBAction func blueTeamEndTimeStepperChanged(_ sender: UIStepper)
   {
      currentTimeBlueTeamEnd = Int( sender.value )
      blueTeamTimeRemainingLabel.text = formatTimerMinutesSeconds( Int(sender.value) )
   }
   
   /*
   func addMenuItems() -> UIMenu
   {
     let menuItems = UIMenu(title: "Choose an End", options: .displayInline, children: [
   
        UIAction(title: "Ends 01", handler:
            { [self] (_) in
               print("Selected Item: ENDS 01 has been selected")
               endsButton.setTitle("1", for: .normal)
               endsButton.titleLabel?.font = UIFont.systemFont(ofSize: 55)
            }),
        UIAction(title: "Ends 02", handler:
            { [self] (_) in
               print("Selected Item: ENDS 02 has been selected")
               endsButton.setTitle("2", for: .normal)
               endsButton.titleLabel?.font = UIFont.systemFont(ofSize: 55)
            }),
        UIAction(title: "Ends 03", handler:
            { [self] (_) in
               print("Selected Item: ENDS 03 has been selected")
               endsButton.setTitle("3", for: .normal)
               endsButton.titleLabel?.font = UIFont.systemFont(ofSize: 55)
            }),
        UIAction(title: "Ends 04", handler:
            { [self] (_) in
               print("Selected Item: ENDS 04 has been selected")
               endsButton.setTitle("4", for: .normal)
               endsButton.titleLabel?.font = UIFont.systemFont(ofSize: 55)
            }),
        UIAction(title: "Ends 05", handler:
            { [self] (_) in
               print("Selected Item: ENDS 05 has been selected")
               endsButton.setTitle("5", for: .normal)
               endsButton.titleLabel?.font = UIFont.systemFont(ofSize: 55)
            }),
        UIAction(title: "Ends 06", handler:
            { [self] (_) in
               print("Selected Item: ENDS 06 has been selected")
               endsButton.setTitle("6", for: .normal)
               endsButton.titleLabel?.font = UIFont.systemFont(ofSize: 55)
            })
     ])
      
      return menuItems
   }
    */
   
   
   //MARK:  - Custom Functions
   
   //Custom Function for formatting Number of Seconds into Human-Readable Minutes:Seconds
   func formatTimerMinutesSeconds(_ totalSeconds: Int) -> String
   {
      let seconds: Int = totalSeconds % 60
      let minutes: Int = (totalSeconds / 60) % 60
      return String(format: "%02d:%02d", minutes, seconds)
   }

}
