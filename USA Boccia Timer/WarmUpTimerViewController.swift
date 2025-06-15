//
//  WarmUpTimerViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/19/24.
//

import UIKit
import Foundation


class WarmUpTimerViewController: UIViewController
{
   
   var newMatchItem: MatchItem?
   var timer: Timer?
   var totalTime: Int = 0
   var timerIsRunning = false
   
   
   @IBOutlet weak var warmUpTimerLabel: UILabel!
   @IBOutlet weak var timerButton: UIButton!
   @IBOutlet weak var resetButton: UIButton!
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      //Set Timer Label Attributes
      warmUpTimerLabel.layer.masksToBounds = true
      warmUpTimerLabel.layer.borderWidth = 2
      warmUpTimerLabel.layer.cornerRadius = 25
      warmUpTimerLabel.layer.borderColor = UIColor.black.cgColor
      
      //Set Time in Variable, and save in warmUpTimerLabel.text
      totalTime = Int(newMatchItem!.warmUpTime)
      warmUpTimerLabel.text = formatTimerMinutesSeconds(totalTime)
       
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("ShowNonTeamSpecificTimer"), object: nil, userInfo: ["message": "Warmup"])
       NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": warmUpTimerLabel.text!])
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
       // Update external display
      NotificationCenter.default.post(name: Notification.Name("DismissTimer"), object: nil, userInfo: ["message": ""])
      
      //Invalidate Timer
      timer?.invalidate()
   }
   
   
   //MARK:  - Actions
   
   @IBAction func startMatch()
   {
      //Close the Warm-Up Screen to reveal the Control Board for the Match
      timer?.invalidate()
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func resetWarmUpTimer()
   {
      //Reset Timer's totalTime Variable to the time specified in the MatchSettings Screen
      totalTime = Int(newMatchItem!.warmUpTime)
      warmUpTimerLabel.text = formatTimerMinutesSeconds(totalTime)
      
      //Update External Display
       NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": totalTime])

      NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": warmUpTimerLabel.text!])
   }
   
   @IBAction func startWarmUpTimer()
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
      warmUpTimerLabel.text = formatTimerMinutesSeconds(totalTime)
      
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": warmUpTimerLabel.text!])
      
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
