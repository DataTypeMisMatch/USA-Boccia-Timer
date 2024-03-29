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
      
      redTeamCumulativeScore = item.redTeamFinalScore + item.redTeamPenaltiesScored
      blueTeamCumulativeScore = item.blueTeamFinalScore + item.blueTeamPenaltiesScored
      
      //Copy all properties into Temp Item
      let tempItemToAppend = EndsItem()
      tempItemToAppend.endNumber = item.endNumber
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
      currentEndNumber = currentEndNumber + 1
      
     
      //Close the Screen
      navigationController?.popViewController(animated: true)
   }
   
   
   
   @IBOutlet weak var classification: UILabel!
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
   
   var newMatchItem = MatchItem()
   var endsItem = [EndsItem]()
   
   var currentEndItem = EndsItem()
   
   var redTeamCumulativeScore = 0
   var blueTeamCumulativeScore = 0
   
   var timeOutTeamColor = ""
   var timeOutType = ""
   var timerRedTeamEnd: Timer?
   var timerBlueTeamEnd: Timer?
   var currentTimeRedTeamEnd = 0
   var currentTimeBlueTeamEnd = 0
   var redTeamEndTimerisPaused = false
   var blueTeamEndTimerisPaused = false
   var currentEndNumber = 0

   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      //Initialize values on the screen
      classification.text = newMatchItem.classification
      redTeamScoreLabel.text = currentEndItem.redTeamFinalScore.description
      blueTeamScoreLabel.text = currentEndItem.blueTeamFinalScore.description
      currentEndLabel.text = currentEndNumber.description
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
      
      //Reset Balls to Non-Thrown
      redTeamBall01.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall02.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall03.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall04.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall05.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall06.image = UIImage(named: "LaunchScreenIcon")
      
      blueTeamBall01.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall02.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall03.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall04.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall05.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall06.image = UIImage(named: "LaunchScreenIcon")
      
      
      timerRedTeamEnd?.invalidate()
      timerBlueTeamEnd?.invalidate()
      
      
      //Check if Game Over
      if (currentEndNumber > newMatchItem.numEnds)
      {
	 
	 /*
	 //Create HUD View
	 guard let mainView = viewController?.parent?.view
	 else { return }
	 let hudView = HudView.hud(inView: mainView, animated: true)
	 hudView.text = "Game Over"
	 
	 let delayInSeconds = 20.0
	 DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds)
	 {
	    hudView.hide()
	       //self.navigationController?.popViewController(animated: true)
	 }
	 */
	 
	 finishButton.isHidden = false
      }
   }
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
   
      currentEndNumber = 1
      
      //Create First End Properties
      let endsVariables = EndsItem()
      endsVariables.endNumber = currentEndNumber
      endsVariables.classification = newMatchItem.classification
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
      
      
      //endsVariables.redTeamBallsPlayed = 0
      //endsVariables.blueTeamBallsPlayed = 0
      
      /*
      //Add all ends and their default variables (so they are available later when Performing Save)
      for _ in stride(from: 0, to: newMatchItem.numEnds, by: 1)
      {
	 endsItem.append(endsVariables)
      }
      */
      
      //Initialize values on the screen
      classification.text = newMatchItem.classification
      redTeamScoreLabel.text = currentEndItem.redTeamFinalScore.description
      blueTeamScoreLabel.text = currentEndItem.blueTeamFinalScore.description
      currentEndLabel.text = currentEndNumber.description
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
      
      //Set Balls to Non-Thrown
      redTeamBall01.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall02.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall03.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall04.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall05.image = UIImage(named: "LaunchScreenIcon")
      redTeamBall06.image = UIImage(named: "LaunchScreenIcon")
      
      blueTeamBall01.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall02.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall03.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall04.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall05.image = UIImage(named: "LaunchScreenIcon")
      blueTeamBall06.image = UIImage(named: "LaunchScreenIcon")
      
      timerRedTeamEnd?.invalidate()
      timerBlueTeamEnd?.invalidate()
      
      
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

      
      //Auto-Show the WarmUp Timer Screen
      performSegue(withIdentifier: "StartWarmUpTimer", sender: nil)
   }
   
   
   //MARK:  - Actions

   @IBAction func finishMatch()
   {
      performSegue(withIdentifier: "FinalScore", sender: nil)
   }
   
   
   @IBAction func inputScore()
   {
      //Add Verification Code
      
      //Fire any Penalties for Blue or Red
           // (remember, if Red gets a Penalty, it is taken by the Blue Team)
      
      performSegue(withIdentifier: "InputScore", sender: nil)
   }
   
   @IBAction func cancel()
   {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func ballClicked(_ gesture: UITapGestureRecognizer)
   {
      if let imageView = gesture.view as? UIImageView 
      {
	 if imageView.image == UIImage(named: "USA_Boccia_Ball_White_NoBackground")
	 {
	    imageView.image = UIImage(named: "LaunchScreenIcon")
	 }
	 else
	 {
	    imageView.image = UIImage(named: "USA_Boccia_Ball_White_NoBackground")
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
	 
	 //Set button title to Pause ||
	 redTeamEndTimeButton.setTitle("∥∥", for: UIControl.State.normal)
	 redTeamEndTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 45)
	 redTeamEndTimerisPaused = true
	 break
      case true:
	 //Stop the Timer (there is no Pause)
	 timerRedTeamEnd?.invalidate()
	 
	 //Set button title to Play |>
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
	 
	 //Set button title to Pause ||
	 blueTeamEndTimeButton.setTitle("∥∥", for: UIControl.State.normal)
	 blueTeamEndTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 45)
	 blueTeamEndTimerisPaused = true
	 break
      case true:
	 //Stop the Timer (there is no Pause)
	 timerBlueTeamEnd?.invalidate()
	 
	 //Set button title to Play |>
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
      blueTeamEndTimeLabel.text = formatTimerMinutesSeconds(currentTimeBlueTeamEnd)
      
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
   }
   
   @IBAction func redTeamPenaltyStepperChanged(_ sender: UIStepper)
   {
      redTeamPenaltyLabel.text = Int(sender.value).description
   }
   
   @IBAction func blueTeamEndTimeStepperChanged(_ sender: UIStepper)
   {
      currentTimeBlueTeamEnd = Int( sender.value )
      blueTeamEndTimeLabel.text = formatTimerMinutesSeconds( Int(sender.value) )
   }
   
   @IBAction func blueTeamPenaltyStepperChanged(_ sender: UIStepper)
   {
      blueTeamPenaltyLabel.text = Int(sender.value).description
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
   
   //Custom Function for formatting Number of Seconds into Human-Readable Minutes:Seconds
   func formatTimerMinutesSeconds(_ totalSeconds: Int) -> String
   {
      let seconds: Int = totalSeconds % 60
      let minutes: Int = (totalSeconds / 60) % 60
      return String(format: "%02d:%02d", minutes, seconds)
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
      else if segue.identifier == "InputScore"
      {
	 let controller = segue.destination as! InputScoreViewController
	 controller.delegate = self
	 
	 controller.currentEndItem = currentEndItem
	 controller.newMatchItem = newMatchItem
	 
	 controller.endsItem = endsItem
	 
	 controller.currentEndNumber = currentEndNumber
	 
	 controller.currentTimeRedTeamEnd = currentTimeRedTeamEnd
	 controller.currentTimeBlueTeamEnd = currentTimeBlueTeamEnd
	 
	 controller.redTeamCumulativeScore = redTeamCumulativeScore
	 controller.blueTeamCumulativeScore = blueTeamCumulativeScore
      }
      else if segue.identifier == "FinalScore"
      {
	 let controller = segue.destination as! FinalScoreViewController
	 
	 controller.currentEndItem = currentEndItem
	 controller.newMatchItem = newMatchItem
	 controller.endsItem = endsItem
      }
   }
   
}
