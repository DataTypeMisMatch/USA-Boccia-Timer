//
//  NewMatchViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/19/24.
//

import UIKit
import Foundation

class NewMatchViewController: UIViewController, InputScoreViewControllerDelegate
{
   func inputScoreViewControllerDidCancel(
      _ controller: InputScoreViewController)
   {
      navigationController?.popViewController(animated: true)
   }
   
   func inputScoreViewController(
      _ controller: InputScoreViewController,
      didFinishAdding item: EndsItem)
   {
      redTeamCumulativeScore = redTeamCumulativeScore + item.redTeamFinalScore + item.redTeamPenaltiesScored
      blueTeamCumulativeScore = blueTeamCumulativeScore + item.blueTeamFinalScore + item.blueTeamPenaltiesScored
      
      //Copy all properties into Temp Item
      let tempItemToAppend = EndsItem()
      
      tempItemToAppend.endNumber = item.endNumber
      
      //Name the End Properly (as End-n or TieBreak-n)
      if(currentEndNumber > newMatchItem.numEnds)
      {
	 tempItemToAppend.endTitle = "Tie Break " + (item.endNumber - newMatchItem.numEnds).description
      }
      else
      {
	 tempItemToAppend.endTitle = "End " + item.endNumber.description
      }
      
      tempItemToAppend.classification = item.classification
      tempItemToAppend.endsTime = item.endsTime
      tempItemToAppend.redTeamName = item.redTeamName
      tempItemToAppend.blueTeamName = item.blueTeamName
      tempItemToAppend.redTeamFlagName = item.redTeamFlagName
      tempItemToAppend.blueTeamFlagName = item.blueTeamFlagName
      tempItemToAppend.redTeamFinalScore = item.redTeamFinalScore
      tempItemToAppend.blueTeamFinalScore = item.blueTeamFinalScore
      tempItemToAppend.redTeamPenaltyCount = item.redTeamPenaltyCount
      tempItemToAppend.blueTeamPenaltyCount = item.blueTeamPenaltyCount
      tempItemToAppend.redTeamMedicalTimeOutCount = item.redTeamMedicalTimeOutCount
      tempItemToAppend.blueTeamMedicalTimeOutCount = item.blueTeamMedicalTimeOutCount
      tempItemToAppend.redTeamTechnicalTimeOutCount = item.redTeamTechnicalTimeOutCount
      tempItemToAppend.blueTeamTechnicalTimeOutCount = item.blueTeamTechnicalTimeOutCount
      tempItemToAppend.redTeamEndTimeRemaining = item.redTeamEndTimeRemaining
      tempItemToAppend.blueTeamEndTimeRemaining = item.blueTeamEndTimeRemaining
      tempItemToAppend.redTeamPenaltiesScored = item.redTeamPenaltiesScored
      tempItemToAppend.blueTeamPenaltiesScored = item.blueTeamPenaltiesScored
      
      //Add Item to the Array
      endsItem.append(tempItemToAppend)
      
      //Increment End Number
      currentEndNumber += 1
      
      
      //Check if Game Over and TieBreaker Necessary
      if (currentEndNumber > newMatchItem.numEnds)
      {
	 //Check if Tie Breaker is necessary (at the end of the last End Section)
	 if ( redTeamCumulativeScore == blueTeamCumulativeScore )
	 {
	    needsTieBreak = true
	 }
      }
      
      
      //Name the End Properly (as End-n or TieBreak-n)
      if(currentEndNumber > newMatchItem.numEnds)
      {
	 currentEndTitle = "Tie Break " + (currentEndNumber - newMatchItem.numEnds).description
      }
      else
      {
	 currentEndTitle = "End " + currentEndNumber.description
      }
      
      
      resetScreen()
      
      //Stop Timers
      timerRedTeamEnd?.invalidate()
      timerBlueTeamEnd?.invalidate()
     
      //Close the Screen
      navigationController?.popViewController(animated: true)
      
      //Set Flag to show the Between-Ends Timer Screen
      needsBetwixtTimer = true
   }
   
   
   
   @IBOutlet weak var gameName: UILabel!
   @IBOutlet weak var redTeamScoreLabel: UILabel!
   @IBOutlet weak var blueTeamScoreLabel: UILabel!
   @IBOutlet weak var currentEndLabel: UILabel!
   
   @IBOutlet weak var redTeamFlagImage: UIImageView!
   @IBOutlet weak var redTeamNameLabel: UILabel!
   @IBOutlet weak var redTeamBall01: UIImageView!
   @IBOutlet weak var redTeamBall02: UIImageView!
   @IBOutlet weak var redTeamBall03: UIImageView!
   @IBOutlet weak var redTeamBall04: UIImageView!
   @IBOutlet weak var redTeamBall05: UIImageView!
   @IBOutlet weak var redTeamBall06: UIImageView!
   @IBOutlet weak var redTeamEndTimeLabel: UILabel!
   @IBOutlet weak var redTeamEndTimeStepper: UIStepper!
   @IBOutlet weak var redTeamEndTimeButton: UIButton!
   @IBOutlet weak var redTeamPenaltyLabel: UILabel!
   @IBOutlet weak var redTeamPenaltyStepper: UIStepper!
   @IBOutlet weak var redTeamPenaltyButton: UIButton!
   
   @IBOutlet weak var blueTeamFlagImage: UIImageView!
   @IBOutlet weak var blueTeamNameLabel: UILabel!
   @IBOutlet weak var blueTeamBall01: UIImageView!
   @IBOutlet weak var blueTeamBall02: UIImageView!
   @IBOutlet weak var blueTeamBall03: UIImageView!
   @IBOutlet weak var blueTeamBall04: UIImageView!
   @IBOutlet weak var blueTeamBall05: UIImageView!
   @IBOutlet weak var blueTeamBall06: UIImageView!
   @IBOutlet weak var blueTeamEndTimeLabel: UILabel!
   @IBOutlet weak var blueTeamEndTimeStepper: UIStepper!
   @IBOutlet weak var blueTeamEndTimeButton: UIButton!
   @IBOutlet weak var blueTeamPenaltyLabel: UILabel!
   @IBOutlet weak var blueTeamPenaltyStepper: UIStepper!
   @IBOutlet weak var blueTeamPenaltyButton: UIButton!
   @IBOutlet weak var finishButton: UIButton!
   
   @IBOutlet weak var blueTeamView: UIView!
   @IBOutlet weak var redTeamView: UIView!
   @IBOutlet weak var headerView: UIView!
   
   @IBOutlet weak var inputScoreBarButton: UIBarButtonItem!
   @IBOutlet weak var cancelScoreBarButton: UIBarButtonItem!
   
   
   var newMatchItem = MatchItem()
   var endsItem = [EndsItem]()
   
   var currentEndItem = EndsItem()
   
   var redTeamCumulativeScore = 0
   var blueTeamCumulativeScore = 0
   
   var redTeamPenaltyCount = 0
   var blueTeamPenaltyCount = 0
   
   var timeOutTeamColor = ""
   var timeOutType = ""
   var timerRedTeamEnd: Timer?
   var timerBlueTeamEnd: Timer?
   var currentTimeRedTeamEnd = 0
   var currentTimeBlueTeamEnd = 0
   var redTeamEndTimerisPaused = false
   var blueTeamEndTimerisPaused = false
   var currentEndNumber = 0
   var currentEndTitle = ""
   
   var needsTieBreak = false
   var needsBetwixtTimer = false
   var numberTieBreaks = 0

   
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      
      //Check if Game Over
      if (needsTieBreak)
      {
	 performSegue(withIdentifier: "StartTieBreak", sender: nil)
	 numberTieBreaks += 1
      }
      else if (currentEndNumber > (newMatchItem.numEnds + numberTieBreaks) )
      {
	 //Hide all items on the screen to indicate Game Over
	 blueTeamView.isHidden = true
	 redTeamView.isHidden = true
	 headerView.isHidden = true
	 
	 inputScoreBarButton.isEnabled = false
	 cancelScoreBarButton.isEnabled = false
	 
	 //Stop Timers
	 timerRedTeamEnd?.invalidate()
	 timerBlueTeamEnd?.invalidate()
	 
	 //Show Finish Button and hide Tie Break Button (if necessary)
	 finishButton.isHidden = false
      }
      else if (currentEndNumber != 1 && needsBetwixtTimer)
      {
	 
	 //Auto-Show the Between-Ends One-Minute Timer Screen
	 performSegue(withIdentifier: "BetwixtEndsTimer", sender: nil)
      }
      
   }
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
   
      currentEndNumber = 1
      
      //Create First End Properties
      let endsVariables = EndsItem()
      
      endsVariables.endNumber = currentEndNumber
      
      endsVariables.gameName = newMatchItem.gameName
      
      //endsVariables.classification = newMatchItem.classification
      
      endsVariables.endsTime = newMatchItem.endsTime
      endsVariables.redTeamName = newMatchItem.redTeamName
      endsVariables.blueTeamName = newMatchItem.blueTeamName
      endsVariables.redTeamFlagName = newMatchItem.redTeamFlagName
      endsVariables.blueTeamFlagName = newMatchItem.blueTeamFlagName
      endsVariables.redTeamFinalScore = 0
      endsVariables.blueTeamFinalScore = 0
      endsVariables.redTeamPenaltyCount = 0
      endsVariables.blueTeamPenaltyCount = 0
      endsVariables.redTeamTechnicalTimeOutCount = 0
      endsVariables.blueTeamTechnicalTimeOutCount = 0
      endsVariables.redTeamMedicalTimeOutCount = 0
      endsVariables.blueTeamMedicalTimeOutCount = 0
      
      currentEndItem = endsVariables
      
      //Set Maximum Values in the Steppers to prevent a subtle bug
      redTeamEndTimeStepper.maximumValue = Double(newMatchItem.endsTime)
      blueTeamEndTimeStepper.maximumValue = Double(newMatchItem.endsTime)
      
      
      //Name the End Properly (as End-n or TieBreak-n)
      if(currentEndNumber > newMatchItem.numEnds)
      {
	 currentEndTitle = "Tie Break " + (currentEndNumber - newMatchItem.numEnds).description
      }
      else
      {
	 currentEndTitle = "End " + currentEndNumber.description
      }
      

      initializeValuesOnScreen()
      formatButtons()
      
      //Auto-Show the WarmUp Timer Screen
      performSegue(withIdentifier: "StartWarmUpTimer", sender: nil)
   }
   
   override func viewWillDisappear(_ animated: Bool) 
   {
      //Invalidate Timers
      timerBlueTeamEnd?.invalidate()
      timerRedTeamEnd?.invalidate()
   }
   
   
   //MARK:  - Actions

   @IBAction func startRedPenaltyTimer()
   {
      timeOutTeamColor = "Blue"
      
      performSegue(withIdentifier: "StartPenaltyTimer", sender: nil)
   }
   
   @IBAction func startBluePenaltyTimer()
   {
      timeOutTeamColor = "Red"
      
      performSegue(withIdentifier: "StartPenaltyTimer", sender: nil)
   }
   
   @IBAction func finishMatch()
   {
      performSegue(withIdentifier: "FinalScoreTableView", sender: nil)
   }
   
   @IBAction func inputScore()
   {
      //Stop Timers
      timerRedTeamEnd?.invalidate()
      timerBlueTeamEnd?.invalidate()
      
      //Show the InputScore Screen
      performSegue(withIdentifier: "InputScore", sender: nil)
   }
   
   @IBAction func cancel()
   {
      navigationController?.popViewController(animated: true)
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("ClearScoreboard"), object: nil, userInfo: ["message": "HardReset"])
   }
   
   @IBAction func redBallClicked(_ gesture: UITapGestureRecognizer)
   {
      if let imageView = gesture.view as? UIImageView
      {
	 if imageView.image == UIImage(named: "USA_Boccia_Ball_Red")
	 {
	    imageView.image = UIImage(named: "USA_Boccia_Ball_White_NoBackground")
	    
	    // Update external display
	    NotificationCenter.default.post(name: Notification.Name("DecrementRedBalls"), object: nil, userInfo: ["message": ""])
	 }
	 else
	 {
	    imageView.image = UIImage(named: "USA_Boccia_Ball_Red")
	    
	    // Update external display
	    NotificationCenter.default.post(name: Notification.Name("IncrementRedBalls"), object: nil, userInfo: ["message": ""])
	 }
      }
   }
   
   @IBAction func blueBallClicked(_ gesture: UITapGestureRecognizer)
   {
      if let imageView = gesture.view as? UIImageView
      {
	 if imageView.image == UIImage(named: "USA_Boccia_Ball_Blue")
	 {
	    imageView.image = UIImage(named: "USA_Boccia_Ball_White_NoBackground")
	    
	    // Update external display
	    NotificationCenter.default.post(name: Notification.Name("DecrementBlueBalls"), object: nil, userInfo: ["message": ""])
	 }
	 else
	 {
	    imageView.image = UIImage(named: "USA_Boccia_Ball_Blue")
	       
	    // Update external display
	    NotificationCenter.default.post(name: Notification.Name("IncrementBlueBalls"), object: nil, userInfo: ["message": ""])
	 }
      }
   }
   
   
   @IBAction func startTimerRedTeam()
   {
      switch (redTeamEndTimerisPaused)
      {
      case false:
	 //Schedule the Timer
	 timerRedTeamEnd = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRedTeamEndTimer), userInfo: nil, repeats: true)
	 
	 //Set button title to Pause ( ∥∥ )
	 redTeamEndTimeButton.setTitle("∥∥", for: UIControl.State.normal)
	 redTeamEndTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 45)
	 redTeamEndTimerisPaused = true
	 break
      case true:
	 //Stop the Timer (there is no Pause)
	 timerRedTeamEnd?.invalidate()
	 
	 //Set button title to Play ( ▶︎ )
	 redTeamEndTimeButton.setTitle("▶︎", for: .normal)
	 redTeamEndTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 45)
	 redTeamEndTimerisPaused = false
	 break
      }
   }
   
   @objc func updateRedTeamEndTimer()
   {
      print(currentTimeRedTeamEnd)
      
      //Set the Text on warmUpTimerLabel.text to the amount saved in totalTime variable
      redTeamEndTimeLabel.text = formatTimerMinutesSeconds(currentTimeRedTeamEnd)
      
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("SetRedTimer"), object: nil, userInfo: ["message": redTeamEndTimeLabel.text!])
      
      //Check if the Timer needs to end
      if currentTimeRedTeamEnd != 0
      {
	 //There is time left, so decrement the timer by one second
	 currentTimeRedTeamEnd = currentTimeRedTeamEnd - 1  // decrease counter timer
      }
      else
      {
	 //No time left, so invalidate the Timer to end it
	 if let timer = self.timerRedTeamEnd
	 {
	    timer.invalidate()
	    self.timerRedTeamEnd = nil
	    currentTimeRedTeamEnd = 0
	 }
      }
   }

   
   @IBAction func startTimerBlueTeam()
   {
      switch (blueTeamEndTimerisPaused)
      {
      case false:
	 //Schedule the Timer
	 timerBlueTeamEnd = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateBlueTeamEndTimer), userInfo: nil, repeats: true)
	 
	 //Set button title to Pause ( ∥∥ )
	 blueTeamEndTimeButton.setTitle("∥∥", for: UIControl.State.normal)
	 blueTeamEndTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 45)
	 blueTeamEndTimerisPaused = true
	 break
      case true:
	 //Stop the Timer (there is no Pause)
	 timerBlueTeamEnd?.invalidate()
	 
	 //Set button title to Play ( ▶︎ )
	 blueTeamEndTimeButton.setTitle("▶︎", for: .normal)
	 blueTeamEndTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 45)
	 blueTeamEndTimerisPaused = false
	 break
      }
   }
   
   @objc func updateBlueTeamEndTimer()
   {
      print(currentTimeBlueTeamEnd)
      
      //Set the Text on warmUpTimerLabel.text to the amount saved in totalTime variable
      blueTeamEndTimeLabel.text = formatTimerMinutesSeconds(currentTimeBlueTeamEnd)// Update external display
       NotificationCenter.default.post(name: Notification.Name("SetBlueTimer"), object: nil, userInfo: ["message": blueTeamEndTimeLabel.text!])
      
      //Check if the Timer needs to end
      if currentTimeBlueTeamEnd != 0
      {
	 //There is time left, so decrement the timer by one second
	 currentTimeBlueTeamEnd = currentTimeBlueTeamEnd - 1  // decrease counter timer
      }
      else
      {
	 //No time left, so invalidate the Timer to end it
	 if let timer = self.timerBlueTeamEnd
	 {
	    timer.invalidate()
	    self.timerBlueTeamEnd = nil
	    currentTimeBlueTeamEnd = 0
	 }
      }
   }
   
   
   @IBAction func redTeamEndTimeStepperChanged(_ sender: UIStepper)
   {
      currentTimeRedTeamEnd = Int( sender.value )
      redTeamEndTimeLabel.text = formatTimerMinutesSeconds( Int(sender.value) )
      
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("SetRedTimer"), object: nil, userInfo: ["message": redTeamEndTimeLabel.text!])
   }
   
   @IBAction func redTeamPenaltyStepperChanged(_ sender: UIStepper)
   {
      redTeamPenaltyCount = Int( sender.value )
      redTeamPenaltyLabel.text = Int( sender.value ).description
      
      if (redTeamPenaltyCount == 0)
      {
	 redTeamPenaltyButton.isEnabled = false
      }
      else
      {
	 redTeamPenaltyButton.isEnabled = true
      }
   }
   
   @IBAction func blueTeamEndTimeStepperChanged(_ sender: UIStepper)
   {
      currentTimeBlueTeamEnd = Int( sender.value )
      blueTeamEndTimeLabel.text = formatTimerMinutesSeconds( Int(sender.value) )
      
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("SetBlueTimer"), object: nil, userInfo: ["message": blueTeamEndTimeLabel.text!])
   }
   
   @IBAction func blueTeamPenaltyStepperChanged(_ sender: UIStepper)
   {
      blueTeamPenaltyCount = Int ( sender.value )
      blueTeamPenaltyLabel.text = Int( sender.value ).description
      
      if (blueTeamPenaltyCount == 0)
      {
	 blueTeamPenaltyButton.isEnabled = false
      }
      else
      {
	 blueTeamPenaltyButton.isEnabled = true
      }
   }
   
   @IBAction func medicalTimeOut_Red()
   {
      timeOutTeamColor = "Red"
      timeOutType = "Medical Timeout"
      
      currentEndItem.redTeamMedicalTimeOutCount += 1
      
      performSegue(withIdentifier: "StartTimeOutTimer", sender: nil)
   }
   
   @IBAction func technicalTimeOut_Red()
   {
      timeOutTeamColor = "Red"
      timeOutType = "Technical Timeout"
      
      currentEndItem.redTeamTechnicalTimeOutCount += 1
      
      performSegue(withIdentifier: "StartTimeOutTimer", sender: nil)
   }
   
   @IBAction func medicalTimeOut_Blue()
   {
      timeOutTeamColor = "Blue"
      timeOutType = "Medical Timeout"
      
      currentEndItem.blueTeamMedicalTimeOutCount += 1
      
      performSegue(withIdentifier: "StartTimeOutTimer", sender: nil)
   }
   
   @IBAction func technicalTimeOut_Blue()
   {
      timeOutTeamColor = "Blue"
      timeOutType = "Technical Timeout"
      
      currentEndItem.blueTeamTechnicalTimeOutCount += 1
      
      performSegue(withIdentifier: "StartTimeOutTimer", sender: nil)
   }
   
   
   //MARK:  - Custom Functions
   
   //Custom Function for formatting Number of Seconds into Human-Readable Minutes:Seconds
   func formatTimerMinutesSeconds(_ totalSeconds: Int) -> String
   {
      let seconds: Int = totalSeconds % 60
      let minutes: Int = (totalSeconds / 60) % 60
      return String(format: "%02d:%02d", minutes, seconds)
   }
   
   func resetScreen()
   {
      //Reset Values to their Defaults for Next End
      gameName.text = newMatchItem.gameName
      redTeamScoreLabel.text = redTeamCumulativeScore.description
      blueTeamScoreLabel.text = blueTeamCumulativeScore.description
      
      //currentEndLabel.text = currentEndNumber.description
      currentEndLabel.text = currentEndTitle
      
      redTeamFlagImage.image = UIImage(named: currentEndItem.redTeamFlagName)
      redTeamNameLabel.text = currentEndItem.redTeamName
      redTeamEndTimeLabel.text = formatTimerMinutesSeconds(newMatchItem.endsTime)
      redTeamPenaltyLabel.text = currentEndItem.redTeamPenaltyCount.description
      blueTeamFlagImage.image = UIImage(named: currentEndItem.blueTeamFlagName)
      blueTeamNameLabel.text = currentEndItem.blueTeamName
      blueTeamEndTimeLabel.text = formatTimerMinutesSeconds(newMatchItem.endsTime)
      blueTeamPenaltyLabel.text = currentEndItem.blueTeamPenaltyCount.description
      
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("SetRedTimer"), object: nil, userInfo: ["message": redTeamEndTimeLabel.text!])
       NotificationCenter.default.post(name: Notification.Name("SetBlueTimer"), object: nil, userInfo: ["message": blueTeamEndTimeLabel.text!])
       NotificationCenter.default.post(name: Notification.Name("NewRedScore"), object: nil, userInfo: ["message": redTeamScoreLabel.text!])
       NotificationCenter.default.post(name: Notification.Name("NewBlueScore"), object: nil, userInfo: ["message": blueTeamScoreLabel.text!])
       
      //Reset Ends Time for Next End
      currentTimeRedTeamEnd = currentEndItem.endsTime
      currentTimeBlueTeamEnd = currentEndItem.endsTime
      
      //Reset the Penalty Counts
      redTeamPenaltyStepper.value = 0
      blueTeamPenaltyStepper.value = 0
      
      //Disable Penalty Buttons until Count is 1 or more
      redTeamPenaltyButton.isEnabled = false
      blueTeamPenaltyButton.isEnabled = false
      
      //Reset Balls to Non-Thrown
      redTeamBall01.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall02.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall03.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall04.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall05.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall06.image = UIImage(named: "USA_Boccia_Ball_Red")
      
      blueTeamBall01.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall02.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall03.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall04.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall05.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall06.image = UIImage(named: "USA_Boccia_Ball_Blue")
   }
   
   func initializeValuesOnScreen()
   {
      //Initialize values on the screen
      gameName.text = newMatchItem.gameName
      redTeamScoreLabel.text = currentEndItem.redTeamFinalScore.description
      blueTeamScoreLabel.text = currentEndItem.blueTeamFinalScore.description
      
      //currentEndLabel.text = currentEndNumber.description
      currentEndLabel.text = currentEndTitle
      
      redTeamFlagImage.image = UIImage(named: currentEndItem.redTeamFlagName)
      redTeamNameLabel.text = currentEndItem.redTeamName
      redTeamEndTimeLabel.text = formatTimerMinutesSeconds(currentEndItem.endsTime)
      redTeamPenaltyLabel.text = currentEndItem.redTeamPenaltyCount.description
      blueTeamFlagImage.image = UIImage(named: currentEndItem.blueTeamFlagName)
      blueTeamNameLabel.text = currentEndItem.blueTeamName
      blueTeamEndTimeLabel.text = formatTimerMinutesSeconds(currentEndItem.endsTime)
      currentTimeRedTeamEnd = currentEndItem.endsTime
      currentTimeBlueTeamEnd = currentEndItem.endsTime
      blueTeamPenaltyLabel.text = currentEndItem.blueTeamPenaltyCount.description
       
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("SetRedTimer"), object: nil, userInfo: ["message": redTeamEndTimeLabel.text!])
       NotificationCenter.default.post(name: Notification.Name("SetBlueTimer"), object: nil, userInfo: ["message": blueTeamEndTimeLabel.text!])
      
      //Disable Penalty Buttons until Count is 1 or more
      redTeamPenaltyButton.isEnabled = false
      blueTeamPenaltyButton.isEnabled = false
      
      //Set Balls to Non-Thrown
      redTeamBall01.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall02.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall03.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall04.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall05.image = UIImage(named: "USA_Boccia_Ball_Red")
      redTeamBall06.image = UIImage(named: "USA_Boccia_Ball_Red")
      
      blueTeamBall01.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall02.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall03.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall04.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall05.image = UIImage(named: "USA_Boccia_Ball_Blue")
      blueTeamBall06.image = UIImage(named: "USA_Boccia_Ball_Blue")
      
      //Stop Timers
      timerRedTeamEnd?.invalidate()
      timerBlueTeamEnd?.invalidate()
   }
   
   func formatButtons()
   {
      //Round Corners of the CountDown Timer and Penalty Labels, and their respective Buttons
      redTeamEndTimeLabel.layer.masksToBounds = true
      redTeamEndTimeLabel.layer.borderWidth = 2
      redTeamEndTimeLabel.layer.cornerRadius = 15
      redTeamEndTimeLabel.layer.borderColor = UIColor.black.cgColor
      
      blueTeamEndTimeLabel.layer.masksToBounds = true
      blueTeamEndTimeLabel.layer.borderWidth = 2
      blueTeamEndTimeLabel.layer.cornerRadius = 15
      blueTeamEndTimeLabel.layer.borderColor = UIColor.black.cgColor
      
      redTeamPenaltyLabel.layer.masksToBounds = true
      redTeamPenaltyLabel.layer.borderWidth = 2
      redTeamPenaltyLabel.layer.cornerRadius = 15
      redTeamPenaltyLabel.layer.borderColor = UIColor.black.cgColor
      
      blueTeamPenaltyLabel.layer.masksToBounds = true
      blueTeamPenaltyLabel.layer.borderWidth = 2
      blueTeamPenaltyLabel.layer.cornerRadius = 15
      blueTeamPenaltyLabel.layer.borderColor = UIColor.black.cgColor
      
      redTeamEndTimeButton.layer.masksToBounds = true
      redTeamEndTimeButton.layer.borderWidth = 2
      redTeamEndTimeButton.layer.cornerRadius = 15
      redTeamEndTimeButton.layer.borderColor = UIColor.black.cgColor
      
      redTeamPenaltyButton.layer.masksToBounds = true
      redTeamPenaltyButton.layer.borderWidth = 2
      redTeamPenaltyButton.layer.cornerRadius = 15
      redTeamPenaltyButton.layer.borderColor = UIColor.black.cgColor
      
      blueTeamEndTimeButton.layer.masksToBounds = true
      blueTeamEndTimeButton.layer.borderWidth = 2
      blueTeamEndTimeButton.layer.cornerRadius = 15
      blueTeamEndTimeButton.layer.borderColor = UIColor.black.cgColor
      
      blueTeamPenaltyButton.layer.masksToBounds = true
      blueTeamPenaltyButton.layer.borderWidth = 2
      blueTeamPenaltyButton.layer.cornerRadius = 15
      blueTeamPenaltyButton.layer.borderColor = UIColor.black.cgColor
      
      //Round Corners and Set Border of the Red and Blue Team Containers
      blueTeamView.layer.masksToBounds = true
      blueTeamView.layer.borderWidth = 4
      blueTeamView.layer.cornerRadius = 15
      blueTeamView.layer.borderColor = UIColor.blue.cgColor
      
      redTeamView.layer.masksToBounds = true
      redTeamView.layer.borderWidth = 4
      redTeamView.layer.cornerRadius = 15
      redTeamView.layer.borderColor = UIColor.red.cgColor
      
      // Calculate the scale by which to enlarge/shrink the stepper
      /*
       Formula:
       hRatio = stepperH/screenH = 0.0321447
       wRatio = stepperW/screenW = 0.133523
       
       scale = ?
       oldButtonH * scale = newButtonH
       where newButtonH/newScreenH = oldButtonH/oldScreenH = hRatio
       
       -> newButtonH = hRatio * newScreenHeight
      */
      
      let newHeight = 0.0321447 * view.bounds.height
      let newWidth = 0.133523 * view.bounds.width
      let xScale = newWidth/redTeamEndTimeStepper.bounds.width
      let yScale = newHeight/redTeamEndTimeStepper.bounds.height
       
      redTeamEndTimeStepper.transform = redTeamEndTimeStepper.transform.scaledBy(x: xScale, y: yScale)
      redTeamPenaltyStepper.transform = redTeamPenaltyStepper.transform.scaledBy(x: xScale, y: yScale)
      blueTeamEndTimeStepper.transform = blueTeamEndTimeStepper.transform.scaledBy(x: xScale, y: yScale)
      blueTeamPenaltyStepper.transform = blueTeamPenaltyStepper.transform.scaledBy(x: xScale, y: yScale)
   }
   
   
   // MARK: - Navigation
   
   override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?)
   {
      
      if segue.identifier == "StartWarmUpTimer"
      {
	 let controller = segue.destination as! WarmUpTimerViewController
	 
	 controller.newMatchItem = newMatchItem
      }
      else if segue.identifier == "StartTimeOutTimer"
      {
	 let controller = segue.destination as! TimeOutViewController
	 
	 controller.teamColor = timeOutTeamColor
	 controller.timeOutType = timeOutType
      }
      else if segue.identifier == "StartPenaltyTimer"
      {
	 let controller = segue.destination as! PenaltyThrowTimerViewController
	 
	 controller.teamColor = timeOutTeamColor
      }
      else if segue.identifier == "InputScore"
      {
	 let controller = segue.destination as! InputScoreViewController
	 controller.delegate = self
	 
	 controller.currentEndItem = currentEndItem
	 controller.newMatchItem = newMatchItem
	 
	 controller.endsItem = endsItem
	 
	 controller.currentEndNumber = currentEndNumber
	 controller.currentEndTitle = currentEndTitle
	 
	 controller.currentTimeRedTeamEnd = currentTimeRedTeamEnd
	 controller.currentTimeBlueTeamEnd = currentTimeBlueTeamEnd
	 
	 controller.needsTieBreak = needsTieBreak
      }
      else if segue.identifier == "FinalScoreTableView"
      {
	 let controller = segue.destination as! FinalScoreTableViewController
	 
	 controller.currentEndItem = currentEndItem
	 controller.newMatchItem = newMatchItem
	 controller.endsItem = endsItem
      }
      else if segue.identifier == "StartTieBreak"
      {
	 let controller = segue.destination as! TieBreakViewController
	 
	 controller.newMatchItem = newMatchItem
	 
	 //Tie Breaker is Done, so toggle the flag back to False
	 needsTieBreak = false
      }
      else if segue.identifier == "BetwixtEndsTimer"
      {
	 let controller = segue.destination as! BetwixtEndsTimerViewController
	 
	 controller.currentEndString = currentEndTitle
	 
	 
	 //Toggle the Flag to False, to prevent this screen from appearing every time NewMatchController
	 // comes into view.  ViewWillAppear( ) is evil like that.
	 needsBetwixtTimer = false
      }
      
   }
   
}
