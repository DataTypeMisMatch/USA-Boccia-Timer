//
//  TimeOutViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/19/24.
//

import UIKit

class TimeOutViewController: UIViewController 
{
   
   var timer: Timer?
   var timeOutDuration: Int = 10 * 60
   var totalTime: Int = 0
   var timeOutType = ""
   var teamColor = ""
   
   
   @IBOutlet weak var timeOutTimerLabel: UILabel!
   @IBOutlet weak var timerButton: UIButton!
   @IBOutlet weak var resetButton: UIButton!
   @IBOutlet weak var teamColorLabel: UILabel!
   @IBOutlet weak var timeOutTypeLabel: UILabel!
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
	
      //Set Timer Label Attributes
      timeOutTimerLabel.layer.masksToBounds = true
      timeOutTimerLabel.layer.borderWidth = 2
      timeOutTimerLabel.layer.cornerRadius = 25
      timeOutTimerLabel.layer.borderColor = UIColor.black.cgColor
      
      //Save TimeOut Time in timeOutTimerLabel.text
      totalTime = timeOutDuration
      timeOutTimerLabel.text = formatTimerMinutesSeconds(totalTime)
      
      timeOutTypeLabel.text = timeOutType
      teamColorLabel.text = teamColor
   }
   
   
      //MARK:  - Actions
   
   @IBAction func resetTimeOutTimer()
   {
      //Reset Timer's totalTime Variable to the time specified in the MatchSettings Screen
      totalTime = timeOutDuration
   }
   
   @IBAction func startTimeOutTimer()
   {
      //Set Timer's totalTime Variable to the time specified in the MatchSettings Screen
      totalTime = timeOutDuration
      
      //Schedule the Timer
      timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
      
      //Disable the user from pressing the Start Timer Button, once it has been started
      timerButton.isEnabled = false
   }
   
   @objc func updateTimer()
   {
      print(totalTime)
      
      //Set the Text on warmUpTimerLabel.text to the amount saved in totalTime variable
      timeOutTimerLabel.text = formatTimerMinutesSeconds(totalTime)
      
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
   
   
   
   
   /*
    // MARK: - Navigation
    
    override func prepare(
    for segue: UIStoryboardSegue,
    sender: Any?)
    {
    
    
    }
    */
   
}
