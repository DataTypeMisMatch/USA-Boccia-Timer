//
//  ViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 1/13/24.
//

import Foundation
import UIKit


class MatchSettingsViewController: UITableViewController, EditTextViewControllerDelegate, EditGameDetailsViewControllerDelegate
{
   func editGameDetailsViewControllerDidCancel(
      _ controller: EditGameDetailsViewController)
   {
      navigationController?.popViewController(animated: true)
   }
   
   func editGameDetailsViewController(
      _ controller: EditGameDetailsViewController, 
      didFinishAddingRedTeamDetails item: MatchItem)
   {
      item.redTeamName = controller.textField.text!
      
      if let cell = cellToEdit
      {
	 updateRedTeamLabel(for: cell, with: item)
      }
      
      navigationController?.popViewController(animated: true)
   }
   
   func editGameDetailsViewController(
      _ controller: EditGameDetailsViewController,
      didFinishAddingBlueTeamDetails item: MatchItem)
   {
      item.blueTeamName = controller.textField.text!
      
      if let cell = cellToEdit
      {
	 updateBlueTeamLabel(for: cell, with: item)
      }
      
      navigationController?.popViewController(animated: true)
   }
   
   func editGameDetailsViewController(
      _ controller: EditGameDetailsViewController,
      didFinishEditing item: MatchItem)
   {
      //add code
   }
   
   
   func editTextViewControllerDidCancel(
      _ controller: EditTextViewController)
   {
      navigationController?.popViewController(animated: true)
   }
   
   func editTextViewController(
      _ controller: EditTextViewController,
      didFinishAdding item: MatchItem)
   {
      item.gameName = controller.textField.text!
      
      if let cell = cellToEdit
      {
	 updateGameLabel(for: cell, with: item)
      }
      
      navigationController?.popViewController(animated: true)
   }
   
   func editTextViewController(
      _ controller: EditTextViewController,
      didFinishEditing item: MatchItem)
   {
      item.gameName = controller.textField.text!
      
      if let cell = cellToEdit
      {
	 updateGameLabel(for: cell, with: item)
      }
      
      navigationController?.popViewController(animated: true)
   }
   

   @IBOutlet weak var gameNameLabel: UILabel!
   @IBOutlet weak var redTeamNameLabel: UILabel!
   @IBOutlet weak var blueTeamNameLabel: UILabel!
   
   @IBOutlet weak var redTeamFlag: UIImageView!
   @IBOutlet weak var blueTeamFlag: UIImageView!
   
   @IBOutlet weak var matchKind: UISegmentedControl!
   @IBOutlet weak var playType: UISegmentedControl!
   
   @IBOutlet weak var bcButton: UIButton!
   
   @IBOutlet weak var ends1Button: UIButton!
   @IBOutlet weak var ends2Button: UIButton!
   @IBOutlet weak var ends3Button: UIButton!
   @IBOutlet weak var ends4Button: UIButton!
   @IBOutlet weak var ends5Button: UIButton!
   @IBOutlet weak var ends6Button: UIButton!
   
   @IBOutlet weak var endTimeLabel: UILabel!
   
   
   var matchItem = MatchItem()
   var cellToEdit: UITableViewCell?
   
   
   //MARK: - Actions
   
   @IBAction func back()
   {
      dismiss(animated: true, completion: nil)
   }
   
   /*
   @IBAction func start()
   {
      //Add Start Code...
      
      //Check that user selected all required MatchItems
      
      //Add Segue to the new screen that will host the Match
      
   }
   */
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      

      //Set Defaults in case User does not trigger the SelectionChanged event in the UISegmentedControls
      matchItem.kind = "Official"
      matchItem.playType = "Single"
      
      //Set Default Classification, in case User does not select any Classification from the DropDown
      matchItem.classification = "BC01"
      
      //Set Classification Button Defaults
      bcButton.showsMenuAsPrimaryAction = true
      
      //Add Menu Items
      bcButton.menu = addMenuItems()
      
      //Round Corners of the CountDown Timer and Penalty Labels, and their respective Buttons
      endTimeLabel.layer.masksToBounds = true
      endTimeLabel.layer.borderWidth = 2
      endTimeLabel.layer.cornerRadius = 15
      endTimeLabel.layer.borderColor = UIColor.black.cgColor
   }
   
   func addMenuItems() -> UIMenu
   {
      let menuItems = UIMenu(title: "Boccia Classifications", options: .displayInline, children: [
	 UIAction(title: "BC01", handler:
		     { [self] (_) in
			print("Selected Item: BC01 has been selected")
			matchItem.classification = "BC01"
			bcButton.setTitle("BC01", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     }),
	 UIAction(title: "BC02", handler:
		     { [self] (_) in
			print("Selected Item: BC02 has been selected")
			matchItem.classification = "BC02"
			bcButton.setTitle("BC02", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     }),
	 UIAction(title: "BC03", handler:
		     { [self] (_) in
			print("Selected Item: BC03 has been selected")
			matchItem.classification = "BC03"
			bcButton.setTitle("BC03", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     }),
	 UIAction(title: "BC04", handler:
		     { [self] (_) in
			print("Selected Item: BC04 has been selected")
			matchItem.classification = "BC04"
			bcButton.setTitle("BC04", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     }),
	 UIAction(title: "BC05", handler:
		     { [self] (_) in
			print("Selected Item: BC05 has been selected")
			matchItem.classification = "BC05"
			bcButton.setTitle("BC05", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     }),
	 UIAction(title: "BC06", handler:
		     { [self] (_) in
			print("Selected Item: BC06 has been selected")
			matchItem.classification = "BC06"
			bcButton.setTitle("BC06", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     }),
	 UIAction(title: "BC07", handler:
		     { [self] (_) in
			print("Selected Item: BC07 has been selected")
			matchItem.classification = "BC07"
			bcButton.setTitle("BC07", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     }),
	 UIAction(title: "BC08", handler:
		     { [self] (_) in
			print("Selected Item: BC08 has been selected")
			matchItem.classification = "BC08"
			bcButton.setTitle("BC08", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     }),
	 UIAction(title: "BC09", handler:
		     { [self] (_) in
			print("Selected Item: BC09 has been selected")
			matchItem.classification = "BC09"
			bcButton.setTitle("BC09", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     }),
	 UIAction(title: "BC10", handler:
		     { [self] (_) in
			print("Selected Item: BC10 has been selected")
			matchItem.classification = "BC10"
			bcButton.setTitle("BC10", for: .normal)
			bcButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
			configureMatch()
		     })
      ])
      
      return menuItems
   }
   
   
   //MARK:  - Table View Data Source
   
   override func numberOfSections(in tableView: UITableView) -> Int 
   {
      return 7
   }
   
  
   @IBAction func matchKindChanged(
      sender: UISegmentedControl)
   {

      if sender.selectedSegmentIndex == 0 
      {
	 print("Selection of MatchKind:  Practice ")
	 matchItem.kind = "Practice"
	 configureMatch()
      }
      else if sender.selectedSegmentIndex == 1
      {
	 print("Selection of MatchKind:  Official ")
	 matchItem.kind = "Official"
	 configureMatch()
      }
   }
   
   @IBAction func playTypeChanged(
      sender: UISegmentedControl)
   {
      
      if sender.selectedSegmentIndex == 0
      {
	 print ("Selection of PlayType:  Single")
	 matchItem.playType = "Single"
	 configureMatch()
      }
      else if sender.selectedSegmentIndex == 1
      {
	 print ("Selection of PlayType:  Pair")
	 matchItem.playType = "Pair"
	 configureMatch()
      }
      else if sender.selectedSegmentIndex == 2
      {
	 print("Selection of PlayType:  Team")

	 matchItem.playType = "Team"
	 matchItem.classification = "BC03"
	 bcButton.setTitle("BC03", for: .normal)
	 configureMatch()
      }
   }
   
   
   
   //MARK:  - Actions
   
   func updateGameLabel(
      for cell: UITableViewCell,
      with item: MatchItem)
   {
      let gameName = cell.viewWithTag(1) as! UILabel
      
      gameName.text = item.gameName
      
      self.matchItem.gameName = item.gameName
   }
   
   func updateRedTeamLabel(
      for cell: UITableViewCell,
      with item: MatchItem)
   {
      let redName = cell.viewWithTag(2) as! UILabel
      
      redName.text = item.redTeamName
      redTeamFlag.image = UIImage(named: item.redTeamFlagName)
      
      self.matchItem.redTeamName = item.redTeamName
      self.matchItem.redTeamFlagName = item.redTeamFlagName
   }
   
   func updateBlueTeamLabel(
      for cell: UITableViewCell,
      with item: MatchItem)
   {
      let blueName = cell.viewWithTag(3) as! UILabel
      
      blueName.text = item.blueTeamName
      blueTeamFlag.image = UIImage(named: item.blueTeamFlagName)
      
      self.matchItem.blueTeamName = item.blueTeamName
      self.matchItem.blueTeamFlagName = item.blueTeamFlagName
   }
   
   func configureMatch()
   {
      setNumberEnds()
      setEndsTimes()
      setWarmUpTime()
   }
   
   func setNumberEnds()
   {
      //Set Number of Ends based on PlayType
      
      switch(matchItem.playType)
      {
      case "Single":
	 matchItem.numEnds = 4
	 break
      case "Pair":
	 matchItem.numEnds = 4
	 break
      case "Team":
	 matchItem.numEnds = 6
	 break
      default:
	 matchItem.numEnds = 4
	 break
      }
      
      //Show or Hide Ends Buttons on Match Settings Screen
      switch(matchItem.numEnds)
      {
      case 4:
	 ends5Button.isHidden = true
	 ends6Button.isHidden = true
	 break
      case 6:
	 ends5Button.isHidden = false
	 ends6Button.isHidden = false
	 break
      default:
	 ends5Button.isHidden = true
	 ends6Button.isHidden = true
	 break
      }
   }
   
   func setEndsTimes()
   {
      //Set Ends Time based on Classification
      
      switch(matchItem.classification)
      {
      case "BC01":
	 matchItem.endsTime = 5 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 5 * 60 )
	 break
      case "BC02":
	 matchItem.endsTime = 5 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 5 * 60 )
	 break
      case "BC03":
	 matchItem.endsTime = 6 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 6 * 60 )
	 break
      case "BC04":
	 matchItem.endsTime = 4 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 4 * 60 )
	 break
      case "BC05":
	 matchItem.endsTime = 4 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 4 * 60 )
	 break
      case "BC06":
	 matchItem.endsTime = 4 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 4 * 60 )
	 break
      case "BC07":
	 matchItem.endsTime = 6 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 6 * 60 )
	 break
      case "BC08":
	 matchItem.endsTime = 4 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 4 * 60 )
	 break
      case "BC09":
	 matchItem.endsTime = 5 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 5 * 60 )
	 break
      case "BC10":
	 matchItem.endsTime = 3 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 3 * 60 )
	 break
      default:
	 matchItem.endsTime = 4 * 60
	 endTimeLabel.text = formatTimerMinutesSeconds( 4 * 60 )
	 break
      }
   }
   
   func setWarmUpTime()
   {
      matchItem.warmUpTime = 2 * 60
   }
   
   //MARK:  - Custom Functions
   
   //Custom Function for formatting Number of Seconds into Human-Readable Minutes:Seconds
   func formatTimerMinutesSeconds(_ totalSeconds: Int) -> String
   {
      let seconds: Int = totalSeconds % 60
      let minutes: Int = (totalSeconds / 60) % 60
      return String(format: "%02d:%02d", minutes, seconds)
   }
   
   //MARK:  - Navigation
 
   override func prepare(
      for segue: UIStoryboardSegue, 
      sender: Any?)
   {
      if segue.identifier == "EditGameName"
      {
	 let controller = segue.destination as! EditTextViewController
	 controller.title = "Edit Game Event Name"
	 controller.delegate = self

	 
	 if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
	 {
	    cellToEdit = tableView.cellForRow(at: indexPath)
	    
	    controller.matchItemToEdit = matchItem
	 }
      }
      else if segue.identifier == "EditRedTeamDetails"
      {
	 let controller = segue.destination as! EditGameDetailsViewController
	 controller.title = "Edit Red Team Details"
	 controller.delegate = self
	 
	 
	 if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
	 {
	    cellToEdit = tableView.cellForRow(at: indexPath)
	    
	    controller.matchItemToEdit = matchItem
	 }
      }
      else if segue.identifier == "EditBlueTeamDetails"
      {
	 let controller = segue.destination as! EditGameDetailsViewController
	 controller.title = "Edit Blue Team Details"
	 controller.delegate = self
	 
	 
	 if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
	 {
	    cellToEdit = tableView.cellForRow(at: indexPath)
	    
	    controller.matchItemToEdit = matchItem
	 }
      }
      else if segue.identifier == "StartNewMatch"
      {
	 let controller = segue.destination as! NewMatchViewController
	 
	 controller.newMatchItem = matchItem
      }
   }
   
}

