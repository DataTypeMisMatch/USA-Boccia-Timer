//
//  EditGameDetailsViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 2/12/24.
//

import Foundation
import UIKit

protocol EditGameDetailsViewControllerDelegate: AnyObject
{
   func editGameDetailsViewControllerDidCancel(
      _ controller: EditGameDetailsViewController)
   
   func editGameDetailsViewController(
      _ controller: EditGameDetailsViewController,
      didFinishAddingRedTeamDetails item: MatchItem)
   
   func editGameDetailsViewController(
      _ controller: EditGameDetailsViewController,
      didFinishAddingBlueTeamDetails item: MatchItem)
   
   func editGameDetailsViewController(
      _ controller: EditGameDetailsViewController,
      didFinishEditing item: MatchItem)
   
}

class EditGameDetailsViewController: UITableViewController, FlagPickerViewControllerDelegate
{
   //MARK:  - Flag Picker View Controller Delegate
   
   func flagPicker(
      _ picker: FlagPickerViewController,
      didPick flagName: String)
   {
      self.flagName = flagName
      
      flagImage.image = UIImage(named: flagName)
      
      navigationController?.popViewController(animated: true)
   }
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      
      if let matchItem = matchItemToEdit
      {
	 switch (title)
	 {
	 case "Edit Red Team Details":
	    textField.text = matchItem.redTeamName
	    flagName = matchItem.redTeamFlagName
	    break
	 case "Edit Blue Team Details":
	    textField.text = matchItem.blueTeamName
	    flagName = matchItem.blueTeamFlagName
	    break
	 default:
	    break
	 }
      }
      
      flagImage.image = UIImage(named: flagName)
   }
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      textField.becomeFirstResponder()
   }
   
   
   //MARK:  - Variables
   
   @IBOutlet weak var textField: UITextField!
   @IBOutlet weak var doneBarButton: UIBarButtonItem!
   @IBOutlet weak var flagImage: UIImageView!
   
   weak var delegate: EditGameDetailsViewControllerDelegate?
   var flagName = "United_States"
   var matchItemToEdit: MatchItem?
   
   
   // MARK: - Table View Data Source
   
   override func numberOfSections(
      in tableView: UITableView) -> Int
   {
      return 2
   }
   
   override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int) -> Int
   {
      return 1
   }
   
   
   //MARK:  - Actions
   
   @IBAction func cancel()
   {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func done()
   {
      print("Contents of TextField: \(textField.text!)")
      
      let item = MatchItem()
      
      switch (title)
      {
      case "Edit Red Team Details":
	 item.redTeamName = textField.text!
	 item.redTeamFlagName = flagName
	 
	 // Update external display
	 NotificationCenter.default.post(name: Notification.Name("NewRedName"), object: nil, userInfo: ["message": item.redTeamName])
	 
	 
	 delegate?.editGameDetailsViewController(self, didFinishAddingRedTeamDetails: item)
	 break
      case "Edit Blue Team Details":
	 item.blueTeamName = textField.text!
	 item.blueTeamFlagName = flagName
	 
	    // Update external display
	 NotificationCenter.default.post(name: Notification.Name("NewBlueName"), object: nil, userInfo: ["message": item.blueTeamName])
	 
	 delegate?.editGameDetailsViewController(self, didFinishAddingBlueTeamDetails: item)
	 break
      default:
	 break
      }
   }
   
   
   // MARK: - Navigation
    
   override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?)
   {
      if segue.identifier == "PickFlag"
      {
	 let controller = segue.destination as! FlagPickerViewController
	 controller.delegate = self
      }
   }
    
}
