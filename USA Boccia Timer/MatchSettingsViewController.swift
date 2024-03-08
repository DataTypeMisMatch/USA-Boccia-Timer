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
   
   @IBOutlet weak var timesDateTimePicker: UIDatePicker!
   
   var gameItem: MatchItem?
   var redTeamItem: MatchItem?
   var blueTeamItem: MatchItem?
   var matchKindItem: MatchItem?
   var playTypeItem: MatchItem?
   var classificationItem: MatchItem?
   
   var cellToEdit: UITableViewCell?
   
   
   
   
   //MARK: - Actions
   
   @IBAction func back()
   {

      dismiss(animated: true, completion: nil)
   }
   
   @IBAction func start()
   {
      //Add Start Code...
      
      //Check that user selected all required MatchItems
      
      //Add Segue to the new screen that will host the Match
      
   }
   
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      

      //Set Defaults in case User does not trigger the SelectionChanged event in the UISegmentedControls
      matchKindItem?.kind = "Official"
      playTypeItem?.kind = "Single"
      
      //Set Default Classification, in case User does not select any Classification from the DropDown
      classificationItem?.kind = "BC01"
      
      //Set Classification Button Defaults
      bcButton.showsMenuAsPrimaryAction = true
      
      //Add Menu Items
      bcButton.menu = addMenuItems()
   }
   
   func addMenuItems() -> UIMenu
   {
      let menuItems = UIMenu(title: "Boccia Classifications", options: .displayInline, children: [
	 UIAction(title: "BC01", handler:
		     { [self] (_) in
			print("Selected Item: BC01 has been selected")
			classificationItem?.classification = "BC01"
		     }),
	 UIAction(title: "BC02", handler:
		     { [self] (_) in
			print("Selected Item: BC02 has been selected")
			classificationItem?.classification = "BC02"
		     }),
	 UIAction(title: "BC03", handler:
		     { [self] (_) in
			print("Selected Item: BC03 has been selected")
			classificationItem?.classification = "BC03"
		     }),
	 UIAction(title: "BC04", handler:
		     { [self] (_) in
			print("Selected Item: BC04 has been selected")
			classificationItem?.classification = "BC04"
		     }),
	 UIAction(title: "BC05", handler:
		     { [self] (_) in
			print("Selected Item: BC05 has been selected")
			classificationItem?.classification = "BC05"
		     }),
	 UIAction(title: "BC06", handler:
		     { [self] (_) in
			print("Selected Item: BC06 has been selected")
			classificationItem?.classification = "BC06"
		     }),
	 UIAction(title: "BC07", handler:
		     { [self] (_) in
			print("Selected Item: BC07 has been selected")
			classificationItem?.classification = "BC07"
		     }),
	 UIAction(title: "BC08", handler:
		     { [self] (_) in
			print("Selected Item: BC08 has been selected")
			classificationItem?.classification = "BC08"
		     }),
	 UIAction(title: "BC09", handler:
		     { [self] (_) in
			print("Selected Item: BC09 has been selected")
			classificationItem?.classification = "BC09"
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
	 matchKindItem?.kind = "Practice"
      }
      else if sender.selectedSegmentIndex == 1
      {
	 print("Selection of MatchKind:  Official ")
	 matchKindItem?.kind = "Official"
      }
   }
   
   @IBAction func playTypeChanged(
      sender: UISegmentedControl)
   {
      
      if sender.selectedSegmentIndex == 0
      {
	 print ("Selection of PlayType:  Single")
	 playTypeItem?.kind = "Single"
      }
      else if sender.selectedSegmentIndex == 1
      {
	 print ("Selection of PlayType:  Pair")
	 playTypeItem?.kind = "Pair"
      }
      else if sender.selectedSegmentIndex == 2
      {
	 print("Selection of PlayType:  Team")
	 playTypeItem?.kind = "Team"
      }
   }
   
   
   
   //MARK:  - Actions
   
   func updateGameLabel(
      for cell: UITableViewCell,
      with item: MatchItem)
   {
      let gameName = cell.viewWithTag(1) as! UILabel
      
      gameName.text = item.gameName
      
      self.gameItem = item
   }
   
   func updateRedTeamLabel(
      for cell: UITableViewCell,
      with item: MatchItem)
   {
      let redName = cell.viewWithTag(2) as! UILabel
      
      redName.text = item.redTeamName
      redTeamFlag.image = UIImage(named: item.redTeamFlagName)
      
      self.redTeamItem = item
   }
   
   func updateBlueTeamLabel(
      for cell: UITableViewCell,
      with item: MatchItem)
   {
      let blueName = cell.viewWithTag(3) as! UILabel
      
      blueName.text = item.blueTeamName
      blueTeamFlag.image = UIImage(named: item.blueTeamFlagName)
      
      self.blueTeamItem = item
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
	    controller.matchItemToEdit = gameItem
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
	    controller.matchItemToEdit = redTeamItem
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
	    controller.matchItemToEdit = blueTeamItem
	 }
      }
   }
   
}

