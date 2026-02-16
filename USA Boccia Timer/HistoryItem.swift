//
//  HistoryItem.swift
//  USA Boccia Timer
//
//  Created by Fox on 5/9/24.
//


import Foundation
import UIKit

class HistoryItem: NSObject, Codable
{
   var dateTimePlayed = Date()
   var gameName = ""
   var team_vs_String = ""
   var redTeamFinalScore = 0
   var blueTeamFinalScore = 0
   var redTeamTieBreakScore = 0
   var blueTeamTieBreakScore = 0
   var playType = ""
   var classification = ""
   var numEnds = 0
   var endsTime = 0
 
   var endsItems = [EndsItem]()
}
