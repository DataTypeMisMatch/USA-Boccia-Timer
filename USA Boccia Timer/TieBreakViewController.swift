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
   var timerIsRunning = false
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
      
      //Set TieBreak Timer time to Current Ends Time
      //tieBreakDuration = Int(newMatchItem.endsTime)
      
      //Save TimeOut Time in timeOutTimerLabel.text
      totalTime = tieBreakDuration
      tieBreakTimerLabel.text = formatTimerMinutesSeconds(totalTime)
       
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("NewTiebreakerEnd"), object: nil, userInfo: ["message": ""])
       NotificationCenter.default.post(name: Notification.Name("ShowNonTeamSpecificTimer"), object: nil, userInfo: ["message": "Tiebreaker"])
       NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": tieBreakTimerLabel.text!])
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      //Invalidate Timer
      timer?.invalidate()
      
      //Update external display
      NotificationCenter.default.post(name: Notification.Name("DismissTimer"), object: nil, userInfo: ["message": ""])
   }
   
   
   //MARK:  - Actions
   
   @IBAction func finish()
   {
      //No Alert Dialogue Needed for the TieBreak Screen...so skipping the call to Present Alert
      /*
      let alert = UIAlertController(title: "Confirm", message: "Finish the Tie Break.  \nStill want to stop the Tie Break?", preferredStyle: UIAlertController.Style.alert)
      
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
     (action: UIAlertAction!) in
     self.alertCancelClicked()
      }))
      
      alert.addAction(UIAlertAction(title: "Finish", style: .default, handler: {
     (action: UIAlertAction!) in
     self.alertFinishClicked()
      }))
  
       //present(alert, animated: true, completion: nil)
       */
      
      
      //Invalidate Timer
      timer?.invalidate()
      
      //Dismiss TieBreak Screen
      navigationController?.popViewController(animated: true)
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
      tieBreakTimerLabel.text = formatTimerMinutesSeconds(totalTime)
      
      //Update External Display
      NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": totalTime])
      
      NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": tieBreakTimerLabel.text!])
   }
   
   @IBAction func startTimeOutTimer()
   {
      //Change the text on the button to "Pause"
      switch (timerIsRunning)
      {
      case false:
	 //Schedule the Timer
	 timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
	 
	 //Set button title to "Pause Timer"
	 timerButton.setTitle("Pause Timer", for: UIControl.State.normal)
	 timerButton.titleLabel?.font = UIFont.systemFont(ofSize: 68, weight: .bold)
	 timerIsRunning = true
	 break
      case true:
	 //Stop the Timer (there is no Pause)
	 timer?.invalidate()
	 
	 //Set button title to "Start Timer"
	 timerButton.setTitle("Start Timer", for: .normal)
	 timerButton.titleLabel?.font = UIFont.systemFont(ofSize: 68, weight: .bold)
	 timerIsRunning = false
	 break
      }
   }
   
   @objc func updateTimer()
   {
      print(totalTime)
      
      //Set the Text on warmUpTimerLabel.text to the amount saved in totalTime variable
      tieBreakTimerLabel.text = formatTimerMinutesSeconds(totalTime)
      
      //Update external display
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
   
}
