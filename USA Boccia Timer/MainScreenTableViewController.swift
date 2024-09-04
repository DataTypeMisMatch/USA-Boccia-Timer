//
//  MainScreenTableViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/7/24.
//

import UIKit

class MainScreenTableViewController: UITableViewController
{
   
   var historyItems = [HistoryItem]()
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
   }
    
    override func viewWillAppear(_ animated: Bool) {
        // Update external display
        NotificationCenter.default.post(name: Notification.Name("ShowIntroScreen"), object: nil, userInfo: ["message": ""])
    }
   
   // MARK: - Table View Data Source
   
   override func numberOfSections(in tableView: UITableView) -> Int
   {
      
      return 2
   }
   
   
    // MARK: - Navigation
    
    override func prepare(
    for segue: UIStoryboardSegue,
    sender: Any?)
    {
       if segue.identifier == "ShowHistory"
       {
	  let navigationController = segue.destination as! UINavigationController
	  let controller = navigationController.topViewController as! HistoryTableViewController
	  
	  controller.historyItems = historyItems
       }
       else if segue.identifier == "ShowNewMatchSettings" {
	 // Update external display
	  NotificationCenter.default.post(name: Notification.Name("ShowScoreboard"), object: nil, userInfo: ["message": ""])
       }
    }
    

}
