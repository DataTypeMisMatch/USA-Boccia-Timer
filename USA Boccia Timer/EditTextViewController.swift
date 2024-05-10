//
//  EditTextViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 1/13/24.
//

import Foundation
import UIKit

protocol EditTextViewControllerDelegate: AnyObject
{
   func editTextViewControllerDidCancel(
      _ controller: EditTextViewController)
   
   func editTextViewController(
      _ controller: EditTextViewController,
      didFinishAdding item: MatchItem)
   
   func editTextViewController(
      _ controller: EditTextViewController,
      didFinishEditing item: MatchItem)
}

class EditTextViewController: UITableViewController 
{

   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      
      if let itemToEdit = matchItemToEdit
      {
	 textField.text = itemToEdit.gameName
      }
      
   }
   
   override func viewWillAppear(_ animated: Bool) 
   {
      super.viewWillAppear(animated)
      
      textField.becomeFirstResponder()
   }
   
   
   //MARK:  - Variables
   
   @IBOutlet weak var textField: UITextField!
   @IBOutlet weak var doneBarButton: UIBarButtonItem!
   
   weak var delegate: EditTextViewControllerDelegate?
   var matchItemToEdit: MatchItem?
   
   
   // MARK: - Table View Data Source
   
   override func numberOfSections(
      in tableView: UITableView) -> Int
   {
      return 1
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
      
      item.gameName = textField.text!
      delegate?.editTextViewController(self, didFinishAdding: item)
   }

    
}
