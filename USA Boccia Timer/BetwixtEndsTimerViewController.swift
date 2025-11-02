//
//  BetwixtEndsTimerViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 8/25/24.
//

import UIKit

class BetwixtEndsTimerViewController: UIViewController
{
   
   var timer: Timer?
   var timeOutDuration: Int = 1 * 60
   var totalTime: Int = 0
   var timerIsRunning = false
   var currentEndString = ""
   
   @IBOutlet weak var nextEndsTimerLabel: UILabel!
   @IBOutlet weak var timerButton: UIButton!
   @IBOutlet weak var resetButton: UIButton!
   @IBOutlet weak var currentEndLabel: UILabel!
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
   
      
      //Set Timer Label Attributes
      nextEndsTimerLabel.layer.masksToBounds = true
      nextEndsTimerLabel.layer.borderWidth = 2
      nextEndsTimerLabel.layer.cornerRadius = 25
      nextEndsTimerLabel.layer.borderColor = UIColor.black.cgColor
      
      //Save TimeOut Time in timeOutTimerLabel.text
      totalTime = timeOutDuration
      nextEndsTimerLabel.text = formatTimerMinutesSeconds(totalTime)
      
      currentEndLabel.text = currentEndString
       
       NotificationCenter.default.post(name: Notification.Name("ShowNonTeamSpecificTimer"), object: nil, userInfo: ["message": "New End"])
      NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": nextEndsTimerLabel.text!])
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
      //Close the Screen
      timer?.invalidate()
      navigationController?.popViewController(animated: true)
   }
   
   /*
   func alertCancelClicked()
   {
	 //Do Nothing
   }
   
   func alertFinishClicked()
   {
      //Close the Screen
      timer?.invalidate()
      navigationController?.popViewController(animated: true)
   }
   */
   
   @IBAction func resetTimeOutTimer()
   {
      //Reset Timer's totalTime Variable to the time specified in the MatchSettings Screen
      totalTime = timeOutDuration
      nextEndsTimerLabel.text = formatTimerMinutesSeconds(totalTime)
       
      //Update External Display
      NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": totalTime])
      NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": nextEndsTimerLabel.text!])
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
      nextEndsTimerLabel.text = formatTimerMinutesSeconds(totalTime)
      
      //Update external display
      NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": nextEndsTimerLabel.text!])
      
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
