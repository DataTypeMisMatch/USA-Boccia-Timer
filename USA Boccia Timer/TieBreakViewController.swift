//
//  TieBreakViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/26/24.
//

import Foundation
import UIKit

class TieBreakViewController: UIViewController
{
   
   var newMatchItem = MatchItem()
   
   var timer: Timer?
   var tieBreakDuration: Int = 1 * 60
   var totalTime: Int = 0
   var teamColor = ""
   
   
   @IBOutlet weak var tieBreakTimerLabel: UILabel!
   @IBOutlet weak var timerButton: UIButton!
   @IBOutlet weak var resetButton: UIButton!
   @IBOutlet weak var tieBreakTypeLabel: UILabel!
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      
      //Set Timer Label Attributes
      tieBreakTimerLabel.layer.masksToBounds = true
      tieBreakTimerLabel.layer.borderWidth = 2
      tieBreakTimerLabel.layer.cornerRadius = 25
      tieBreakTimerLabel.layer.borderColor = UIColor.black.cgColor
      
      //Save TimeOut Time in timeOutTimerLabel.text
      totalTime = tieBreakDuration
      tieBreakTimerLabel.text = formatTimerMinutesSeconds(totalTime)
       
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("NewTiebreakerEnd"), object: nil, userInfo: ["message": ""])
       NotificationCenter.default.post(name: Notification.Name("ShowNonTeamSpecificTimer"), object: nil, userInfo: ["message": "Tiebreaker"])
       NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": tieBreakTimerLabel.text!])
   }
   
   
   //MARK:  - Actions
   
   @IBAction func finish()
   {
      
      let alert = UIAlertController(title: "Confirm", message: "Finish the Tie Break.  \nStill want to stop the Tie Break?", preferredStyle: UIAlertController.Style.alert)
      
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
     (action: UIAlertAction!) in
     self.alertCancelClicked()
      }))
      
      alert.addAction(UIAlertAction(title: "Finish", style: .default, handler: {
     (action: UIAlertAction!) in
     self.alertFinishClicked()
      }))
      
      
      //Check if Timer has Finished...if not, display alert
      if (totalTime > 0)
      {
     //present(alert, animated: true, completion: nil)
     timer?.invalidate()
     navigationController?.popViewController(animated: true)
      }
   }
   
   func alertCancelClicked()
   {
     //Do Nothing
   }
   
   func alertFinishClicked()
   {
      //Close the TimeOut Screen
      timer?.invalidate()
      navigationController?.popViewController(animated: true)
   }
   
   
   @IBAction func resetTimeOutTimer()
   {
      //Reset Timer's totalTime Variable to the time specified in the MatchSettings Screen
      totalTime = tieBreakDuration
   }
   
   @IBAction func startTimeOutTimer()
   {
      //Set Timer's totalTime Variable to the time specified in the MatchSettings Screen
      totalTime = tieBreakDuration
      
      //Schedule the Timer
      timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
      
      //Disable the user from pressing the Start Timer Button, once it has been started
      timerButton.isEnabled = false
   }
   
   @objc func updateTimer()
   {
      print(totalTime)
      
      //Set the Text on warmUpTimerLabel.text to the amount saved in totalTime variable
      tieBreakTimerLabel.text = formatTimerMinutesSeconds(totalTime)
       
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": tieBreakTimerLabel.text!])
      
      //Check if the Timer needs to end
      if totalTime != 0
      {
     //There is time left, so decrement the timer by one second
     totalTime = totalTime - 1  // decrease counter timer
      }
      else
      {
     //No time left, so invalidate the Timer to end it
     if let timer = self.timer
     {
        timer.invalidate()
        self.timer = nil
     }
     
        //Re-Enable the user to start the timer again (if needed)
        //TODO: - Remove this next line if not necessary...likely will just end then Close the Screen
     timerButton.isEnabled = true
      }
   }
   
   func formatTimerMinutesSeconds(_ totalSeconds: Int) -> String
   {
      //Format the Total Seconds Integer: to human-readable Minutes and Seconds
      let seconds: Int = totalSeconds % 60
      let minutes: Int = (totalSeconds / 60) % 60
      return String(format: "%02d:%02d", minutes, seconds)
   }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Update external display
        NotificationCenter.default.post(name: Notification.Name("DismissTimer"), object: nil, userInfo: ["message": ""])
    }
   
}
