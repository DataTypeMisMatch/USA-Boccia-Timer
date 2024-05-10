//
//  HistoryTableViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 5/9/24.
//

import UIKit

class HistoryTableViewController: UITableViewController 
{

   var historyItems = [HistoryItem]()
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      
      //Load History Items
      loadHistoryItems()
   }

   
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
      return historyItems.count
   }

   override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let item = historyItems[indexPath.row]
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
      
      let dateTimePlayedLabel = cell.viewWithTag(1) as! UILabel
      let gameNameLabel = cell.viewWithTag(2) as! UILabel
      let team_vs_StringLabel = cell.viewWithTag(3) as! UILabel
      let redTeamFinalScoreLabel = cell.viewWithTag(4) as! UILabel
      let blueTeamFinalScoreLabel = cell.viewWithTag(5) as! UILabel
      let playTypeLabel = cell.viewWithTag(6) as! UILabel
      let classificationLabel = cell.viewWithTag(7) as! UILabel
      let numEndsLabel = cell.viewWithTag(8) as! UILabel
      let endsTimeLabel = cell.viewWithTag(9) as! UILabel
      
      dateTimePlayedLabel.text = formatDate( item.dateTimePlayed )
      gameNameLabel.text = item.gameName
      team_vs_StringLabel.text = item.team_vs_String
      redTeamFinalScoreLabel.text = item.redTeamFinalScore.description
      blueTeamFinalScoreLabel.text = item.blueTeamFinalScore.description
      playTypeLabel.text = item.playType
      classificationLabel.text = item.classification
      numEndsLabel.text = item.numEnds.description
      endsTimeLabel.text = formatTimerMinutesSeconds( item.endsTime )
      
      
      return cell
   }
   
   
   //MARK:  - Actions
   
   @IBAction func done()
   {
      dismiss(animated: true)
   }
   
   @IBAction func cancel()
   {
      dismiss(animated: true)
   }
   
   
   //MARK:  - Custom Functions
   
   func formatTimerMinutesSeconds(_ totalSeconds: Int) -> String
   {
      //Format the Total Seconds Integer: to human-readable Minutes and Seconds
      let seconds: Int = totalSeconds % 60
      let minutes: Int = (totalSeconds / 60) % 60
      
      return String(format: "%02d:%02d", minutes, seconds)
   }
   
   func formatDate(_ date: Date) -> String
   {
      //Format the Date to a human-readable style
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
      let formattedDate = dateFormatter.string(from: date)
      
      
      return formattedDate
   }
   
   func loadHistoryItems()
   {
      //Load HistoryItems from File
      let path = dataFilePath()
      
      if let data = try? Data(contentsOf: path)
      {
	 
	 let decoder = PropertyListDecoder()
	 
	 do
	 {
	    historyItems = try decoder.decode([HistoryItem].self, from: data)
	    
	    print("Load Successful!")
	 }
	 catch
	 {
	    print("Error decoding historyItem array: \(error.localizedDescription)")
	 }
      }
   }
   
   func documentsDirectory() -> URL
   {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      
      return paths[0]
   }
   
   func dataFilePath() -> URL
   {
      return documentsDirectory().appendingPathComponent("USA_Boccia_Timer_app.plist")
   }

}
