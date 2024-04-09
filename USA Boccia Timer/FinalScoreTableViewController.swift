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
      
      endLabel.text = "End " + item.endNumber.description
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
      
      
      //Sum up the Total Points, based on the Number of Ends
      for index in stride(from: 0, to: newMatchItem.numEnds, by: 1)
      {
	 redTeamTotalGameScore = redTeamTotalGameScore + endsItem[index].redTeamFinalScore + endsItem[index].redTeamPenaltiesScored
	 
	 blueTeamTotalGameScore = blueTeamTotalGameScore + endsItem[index].blueTeamFinalScore + endsItem[index].blueTeamPenaltiesScored
      }
      
      //Set the Final Score Labels to show the freshly calculated values
      redTeamFinalScore.text = redTeamTotalGameScore.description
      blueTeamFinalScore.text = blueTeamTotalGameScore.description
      
   }
   
   
   //MARK:  - Actions
   
   @IBAction func done()
   {
      navigationController?.popViewController(animated: true)
   }
   
   
   //MARK:  Custom Functions
   
   func formatTimerMinutesSeconds(_ totalSeconds: Int) -> String
   {
      //Format the Total Seconds Integer: to human-readable Minutes and Seconds
      let seconds: Int = totalSeconds % 60
      let minutes: Int = (totalSeconds / 60) % 60
      return String(format: "%02d:%02d", minutes, seconds)
   }
   
   
   /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    }
    */
   
}
