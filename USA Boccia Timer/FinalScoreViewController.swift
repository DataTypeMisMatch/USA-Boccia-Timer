//
//  FinalScoreViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/26/24.
//

import Foundation
import UIKit

class FinalScoreViewController: UIViewController 
{
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
   @IBOutlet weak var end01Label: UILabel!
   @IBOutlet weak var end02Label: UILabel!
   @IBOutlet weak var end03Label: UILabel!
   @IBOutlet weak var end04Label: UILabel!
   @IBOutlet weak var end05Label: UILabel!
   @IBOutlet weak var end06Label: UILabel!
   @IBOutlet weak var redTeamEnd01Score: UILabel!
   @IBOutlet weak var redTeamEnd02Score: UILabel!
   @IBOutlet weak var redTeamEnd03Score: UILabel!
   @IBOutlet weak var redTeamEnd04Score: UILabel!
   @IBOutlet weak var redTeamEnd05Score: UILabel!
   @IBOutlet weak var redTeamEnd06Score: UILabel!
   @IBOutlet weak var redTeamEnd01TimeRemaining: UILabel!
   @IBOutlet weak var redTeamEnd02TimeRemaining: UILabel!
   @IBOutlet weak var redTeamEnd03TimeRemaining: UILabel!
   @IBOutlet weak var redTeamEnd04TimeRemaining: UILabel!
   @IBOutlet weak var redTeamEnd05TimeRemaining: UILabel!
   @IBOutlet weak var redTeamEnd06TimeRemaining: UILabel!
   @IBOutlet weak var blueTeamEnd01Score: UILabel!
   @IBOutlet weak var blueTeamEnd02Score: UILabel!
   @IBOutlet weak var blueTeamEnd03Score: UILabel!
   @IBOutlet weak var blueTeamEnd04Score: UILabel!
   @IBOutlet weak var blueTeamEnd05Score: UILabel!
   @IBOutlet weak var blueTeamEnd06Score: UILabel!
   @IBOutlet weak var blueTeamEnd01TimeRemaining: UILabel!
   @IBOutlet weak var blueTeamEnd02TimeRemaining: UILabel!
   @IBOutlet weak var blueTeamEnd03TimeRemaining: UILabel!
   @IBOutlet weak var blueTeamEnd04TimeRemaining: UILabel!
   @IBOutlet weak var blueTeamEnd05TimeRemaining: UILabel!
   @IBOutlet weak var blueTeamEnd06TimeRemaining: UILabel!

   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      //Set Items on the Screen from values saved in the Array
      gameName.text = newMatchItem.gameName
      teamVersusString = newMatchItem.redTeamName + " vs " + newMatchItem.blueTeamName
      teamVersusStringLabel.text = teamVersusString
      playType.text = newMatchItem.playType
      classification.text = newMatchItem.classification
      numEnds.text = newMatchItem.numEnds.description
      endsTime.text = formatTimerMinutesSeconds(newMatchItem.endsTime)
      redTeamEnd01Score.text = endsItem[0].redTeamFinalScore.description
      redTeamEnd02Score.text = endsItem[1].redTeamFinalScore.description
      redTeamEnd03Score.text = endsItem[2].redTeamFinalScore.description
      redTeamEnd04Score.text = endsItem[3].redTeamFinalScore.description
      redTeamEnd01TimeRemaining.text = endsItem[0].redTeamEndTimeRemaining.description
      redTeamEnd02TimeRemaining.text = endsItem[1].redTeamEndTimeRemaining.description
      redTeamEnd03TimeRemaining.text = endsItem[2].redTeamEndTimeRemaining.description
      redTeamEnd04TimeRemaining.text = endsItem[3].redTeamEndTimeRemaining.description
      blueTeamEnd01Score.text = endsItem[0].blueTeamFinalScore.description
      blueTeamEnd02Score.text = endsItem[1].blueTeamFinalScore.description
      blueTeamEnd03Score.text = endsItem[2].blueTeamFinalScore.description
      blueTeamEnd04Score.text = endsItem[3].blueTeamFinalScore.description
      blueTeamEnd01TimeRemaining.text = endsItem[0].blueTeamEndTimeRemaining.description
      blueTeamEnd02TimeRemaining.text = endsItem[1].blueTeamEndTimeRemaining.description
      blueTeamEnd03TimeRemaining.text = endsItem[2].blueTeamEndTimeRemaining.description
      blueTeamEnd04TimeRemaining.text = endsItem[3].blueTeamEndTimeRemaining.description

      //Adjust Items on the Screen to either 4 or 6 ENDS
      switch(newMatchItem.numEnds)
      {
      case 4:
	 end05Label.isHidden = true
	 end06Label.isHidden = true
	 redTeamEnd05Score.isHidden = true
	 redTeamEnd06Score.isHidden = true
	 redTeamEnd05TimeRemaining.isHidden = true
	 redTeamEnd06TimeRemaining.isHidden = true
	 blueTeamEnd05Score.isHidden = true
	 blueTeamEnd06Score.isHidden = true
	 blueTeamEnd05TimeRemaining.isHidden = true
	 blueTeamEnd06TimeRemaining.isHidden = true
	break
      case 6:
	 end05Label.isHidden = false
	 end06Label.isHidden = false
	 redTeamEnd05Score.text = endsItem[4].redTeamFinalScore.description
	 redTeamEnd06Score.text = endsItem[5].redTeamFinalScore.description
	 redTeamEnd05TimeRemaining.text = endsItem[4].redTeamEndTimeRemaining.description
	 redTeamEnd06TimeRemaining.text = endsItem[5].redTeamEndTimeRemaining.description
	 blueTeamEnd05Score.text = endsItem[4].blueTeamFinalScore.description
	 blueTeamEnd06Score.text = endsItem[5].blueTeamFinalScore.description
	 blueTeamEnd05TimeRemaining.text = endsItem[4].blueTeamEndTimeRemaining.description
	 blueTeamEnd06TimeRemaining.text = endsItem[5].blueTeamEndTimeRemaining.description
	 break
      default:
	 break
      }
      
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
