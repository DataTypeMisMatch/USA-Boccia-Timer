//
//  FinalScoreViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/26/24.
//

import Foundation
import UIKit

class FinalScoreTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
   
   //MARK:  - TableView Data Source
   func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int) -> Int
   {
      return endsItem.count
   }
   
   func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: "FinalScoreCell", for: indexPath)
      
      let item = endsItem[indexPath.row]
      
      let endLabel = cell.viewWithTag(1) as! UILabel
      let redScoreLabel = cell.viewWithTag(2) as! UILabel
      let redTimeLabel = cell.viewWithTag(3) as! UILabel
      let blueScoreLabel = cell.viewWithTag(4) as! UILabel
      let blueTimeLabel = cell.viewWithTag(5) as! UILabel
      
      endLabel.text = item.endTitle
      redScoreLabel.text = item.redTeamFinalScore.description
      redTimeLabel.text = formatTimerMinutesSeconds( item.redTeamEndTimeRemaining )
      blueScoreLabel.text = item.blueTeamFinalScore.description
      blueTimeLabel.text = formatTimerMinutesSeconds( item.blueTeamEndTimeRemaining )
      
      //Round Corners of the Ends Label
      endLabel.layer.masksToBounds = true
      endLabel.layer.borderWidth = 2
      endLabel.layer.cornerRadius = 15
      endLabel.layer.borderColor = UIColor.black.cgColor
      
      
      return cell
   }
   
   
   var endsItem = [EndsItem]()
   var currentEndItem = EndsItem()
   var newMatchItem = MatchItem()
   var historyItems = [HistoryItem]()
   
   var teamVersusString = ""
   var redTeamTotalGameScore = 0
   var blueTeamTotalGameScore = 0
   
   @IBOutlet weak var gameName: UILabel!
   @IBOutlet weak var teamVersusStringLabel: UILabel!
   @IBOutlet weak var redTeamFinalScore: UILabel!
   @IBOutlet weak var blueTeamFinalScore: UILabel!
   @IBOutlet weak var playType: UILabel!
   @IBOutlet weak var classification: UILabel!
   @IBOutlet weak var numEnds: UILabel!
   @IBOutlet weak var endsTime: UILabel!
   
   @IBOutlet weak var tableView: UITableView!
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      tableView.dataSource = self
      tableView.delegate = self
      
      
      //Set Items on the Screen from values saved in the Array
      gameName.text = newMatchItem.gameName
      teamVersusString = newMatchItem.redTeamName + " vs " + newMatchItem.blueTeamName
      teamVersusStringLabel.text = teamVersusString
      playType.text = newMatchItem.playType
      classification.text = newMatchItem.classification
      numEnds.text = newMatchItem.numEnds.description
      endsTime.text = formatTimerMinutesSeconds(newMatchItem.endsTime)
      
      
      /*
      //Sum up the Total Points, based on the Number of Ends actually played (including TieBreakers)
      for index in stride(from: 0, to: endsItem.count, by: 1)
      {
	 //Calculate Game-Total Scores for each side
	 redTeamTotalGameScore = redTeamTotalGameScore + endsItem[index].redTeamFinalScore + endsItem[index].redTeamPenaltiesScored
	 
	 blueTeamTotalGameScore = blueTeamTotalGameScore + endsItem[index].blueTeamFinalScore + endsItem[index].blueTeamPenaltiesScored
	 
	 //Calculate Total Ends Score for each side
	 endsItem[index].redTeamFinalScore = endsItem[index].redTeamFinalScore + endsItem[index].redTeamPenaltiesScored
	 
	 endsItem[index].blueTeamFinalScore = endsItem[index].blueTeamFinalScore + endsItem[index].blueTeamPenaltiesScored
      }
      */
      
      
      //Sum up the Total Points, based on the Number of Ends actually played (EXCLUDING TieBreakers)
      for index in stride(from: 0, to: newMatchItem.numEnds, by: 1)
      {
	 //Calculate Game-Total Scores for each side
	 redTeamTotalGameScore = redTeamTotalGameScore + endsItem[index].redTeamFinalScore + endsItem[index].redTeamPenaltiesScored
	 
	 blueTeamTotalGameScore = blueTeamTotalGameScore + endsItem[index].blueTeamFinalScore + endsItem[index].blueTeamPenaltiesScored
	 
	 //Calculate Total Ends Score for each side
	 endsItem[index].redTeamFinalScore = endsItem[index].redTeamFinalScore + endsItem[index].redTeamPenaltiesScored
	 
	 endsItem[index].blueTeamFinalScore = endsItem[index].blueTeamFinalScore + endsItem[index].blueTeamPenaltiesScored
      }
       
      
      //Set the Final Score Labels to show the freshly calculated values
      redTeamFinalScore.text = redTeamTotalGameScore.description
      blueTeamFinalScore.text = blueTeamTotalGameScore.description
      
      //Get Information as to where the Documents Directory is stored
      print("Documents folder is \(documentsDirectory())")
      print("Data file path is \(dataFilePath())")
       
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("ShowWinner"), object: nil, userInfo: ["message": [redTeamFinalScore.text, blueTeamFinalScore.text]])
      
   }
   
   
   //MARK:  - Actions
   
   @IBAction func cancel()
   {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func done()
   {
      //Load the existing HistoryItems from File
      loadHistoryItems()
      
      //Save the HistoryItems Array to File
      saveHistoryItems()
      
      //Return to the beginning of the app
      performSegue(withIdentifier: "ReturnToStart", sender: nil)
       
       // Update external display
       NotificationCenter.default.post(name: Notification.Name("ShowIntroScreen"), object: nil, userInfo: ["message": ""])
   }
   
   
   //MARK:  Custom Functions
   
   func formatTimerMinutesSeconds(_ totalSeconds: Int) -> String
   {
      //Format the Total Seconds Integer: to human-readable Minutes and Seconds
      let seconds: Int = totalSeconds % 60
      let minutes: Int = (totalSeconds / 60) % 60
      return String(format: "%02d:%02d", minutes, seconds)
   }
   
   func saveHistoryItems()
   {
      //Copy the required information into the new Array
      let tempHistoryItem = HistoryItem()
      
      tempHistoryItem.dateTimePlayed = Date()
      tempHistoryItem.gameName = newMatchItem.gameName
      tempHistoryItem.team_vs_String = teamVersusString
      tempHistoryItem.redTeamFinalScore = redTeamTotalGameScore
      tempHistoryItem.blueTeamFinalScore = blueTeamTotalGameScore
      tempHistoryItem.playType = newMatchItem.playType
      tempHistoryItem.classification = newMatchItem.classification
      tempHistoryItem.numEnds = newMatchItem.numEnds
      tempHistoryItem.endsTime =  newMatchItem.endsTime
      
      //Copy Ends Results Array
      tempHistoryItem.endsItems = endsItem
      
      historyItems.append(tempHistoryItem)
      
      
      //Save Data to File
      let encoder = PropertyListEncoder()
      
      do
      {
     let data = try encoder.encode(historyItems)
     try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
     
     print("Save Successful!")
      }
      catch
      {
     print("Error encoding historyItem array: \(error.localizedDescription)")
      }
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
   
   
    // MARK: - Navigation
    
   override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?)
   {
      
      if segue.identifier == "ReturnToStart"
      {
     let controller = segue.destination as! MainScreenTableViewController
     
     controller.historyItems = historyItems
      }
   }
   
}
