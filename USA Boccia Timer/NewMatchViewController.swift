//
//  NewMatchViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/19/24.
//

import UIKit

class NewMatchViewController: UIViewController
{
   
   
   @IBOutlet weak var eventNameTextField: UITextField!
   @IBOutlet weak var redTeamNameTextField: UITextField!
   @IBOutlet weak var blueTeamNameTextField: UITextField!
   @IBOutlet weak var matchKindTextField: UITextField!
   @IBOutlet weak var playTypeTextField: UITextField!
   @IBOutlet weak var classificationTextField: UITextField!
   @IBOutlet weak var endsTextField: UITextField!
   @IBOutlet weak var timesTextField: UITextField!
   @IBOutlet weak var warmUpTimeTextField: UITextField!
   
   
   var newMatchItem: MatchItem?
   var timeOutTeamColor = ""
   var timeOutType = ""
   
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
	 
      
      eventNameTextField.text = newMatchItem?.gameName
      redTeamNameTextField.text = newMatchItem?.redTeamName
      blueTeamNameTextField.text = newMatchItem?.blueTeamName
      matchKindTextField.text = newMatchItem?.kind
      playTypeTextField.text = newMatchItem?.playType
      classificationTextField.text = newMatchItem?.classification
      endsTextField.text = "\(newMatchItem?.numEnds ?? -69)"
      timesTextField.text = "\(newMatchItem?.endsTime ?? -69)"
      warmUpTimeTextField.text = "\(newMatchItem?.warmUpTime ?? -69)"
      
      //Auto-Show the WarmUp Timer Screen
      performSegue(withIdentifier: "StartWarmUpTimer", sender: nil)
      
   }
   
   
   //MARK:  - Actions
   
   @IBAction func medicalTimeOut_Red()
   {
      timeOutTeamColor = "Red"
      timeOutType = "Medical Timeout"
      
      performSegue(withIdentifier: "StartTimeOutTimer", sender: nil)
   }
   
   @IBAction func technicalTimeOut_Red()
   {
      timeOutTeamColor = "Red"
      timeOutType = "Technical Timeout"
      
      performSegue(withIdentifier: "StartTimeOutTimer", sender: nil)
   }
   
   @IBAction func medicalTimeOut_Blue()
   {
      timeOutTeamColor = "Blue"
      timeOutType = "Medical Timeout"
      
      performSegue(withIdentifier: "StartTimeOutTimer", sender: nil)
   }
   
   @IBAction func technicalTimeOut_Blue()
   {
      timeOutTeamColor = "Blue"
      timeOutType = "Technical Timeout"
      
      performSegue(withIdentifier: "StartTimeOutTimer", sender: nil)
   }
   
    // MARK: - Navigation
    
   override func prepare(
      for segue: UIStoryboardSegue, 
      sender: Any?)
   {
      
      if segue.identifier == "StartWarmUpTimer"
      {
	 let controller = segue.destination as! WarmUpTimerViewController
	 //controller.title = "Warm Up Timer"
	 
	 controller.newMatchItem = newMatchItem
      }
      else if segue.identifier == "StartTimeOutTimer"
      {
	 let controller = segue.destination as! TimeOutViewController
	 //controller.title = "Medical or Technical Timeout"
	 
	 controller.teamColor = timeOutTeamColor
	 controller.timeOutType = timeOutType
      }
      
   }
   
}
