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
   
   @IBOutlet weak var practiceButton: UIButton!
   @IBOutlet weak var officialButton: UIButton!
   
   @IBOutlet weak var singleButton: UIButton!
   @IBOutlet weak var pairButton: UIButton!
   @IBOutlet weak var teamButton: UIButton!
   
   @IBOutlet weak var bcButton: UIButton!
   
   @IBOutlet weak var ends1Button: UIButton!
   @IBOutlet weak var ends2Button: UIButton!
   @IBOutlet weak var ends3Button: UIButton!
   @IBOutlet weak var ends4Button: UIButton!
   @IBOutlet weak var ends5Button: UIButton!
   @IBOutlet weak var ends6Button: UIButton!
   
   @IBOutlet weak var timesDateTimePicker: UIDatePicker!
   
   var item: MatchItem?
   var cellToEdit: UITableViewCell?
   
   
   //MARK: - Actions
   
   @IBAction func back()
   {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func start()
   {
      //Add Start Code
   }
   
   @IBAction func menuAction()
   {
      
   }
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
   }
   
   
   //MARK:  - Table View Data Source
   
   override func numberOfSections(in tableView: UITableView) -> Int 
   {
      return 7
   }
   
   
   //MARK:  - Actions
   
   func updateGameLabel(
      for cell: UITableViewCell,
      with item: MatchItem)
   {
      let gameName = cell.viewWithTag(1) as! UILabel
      
      gameName.text = item.gameName
   }
   
   func updateRedTeamLabel(
      for cell: UITableViewCell,
      with item: MatchItem)
   {
      let redName = cell.viewWithTag(2) as! UILabel
      
      redName.text = item.redTeamName
   }
   
   func updateBlueTeamLabel(
      for cell: UITableViewCell,
      with item: MatchItem)
   {
      let blueName = cell.viewWithTag(3) as! UILabel
      
      blueName.text = item.blueTeamName
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
	 controller.matchItemToEdit = item
	 
	 if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
	 {
	    cellToEdit = tableView.cellForRow(at: indexPath)
	 }
	 
      }
      else if segue.identifier == "EditRedTeamDetails"
      {
	 let controller = segue.destination as! EditGameDetailsViewController
	 controller.title = "Edit Red Team Details"
	 controller.delegate = self
	 controller.matchItemToEdit = item
	 
	 if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
	 {
	    cellToEdit = tableView.cellForRow(at: indexPath)
	 }
      }
      else if segue.identifier == "EditBlueTeamDetails"
      {
	 let controller = segue.destination as! EditGameDetailsViewController
	 controller.title = "Edit Blue Team Details"
	 controller.delegate = self
	 controller.matchItemToEdit = item
	 
	 if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
	 {
	    cellToEdit = tableView.cellForRow(at: indexPath)
	 }
      }
   }
   
}

