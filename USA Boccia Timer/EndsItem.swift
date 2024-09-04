//
//  EndsItem.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/23/24.
//

import Foundation
import UIKit

class EndsItem: NSObject, Codable
{
   var endNumber = 0
   var endTitle = ""
   
   var classification = ""
   var gameName = ""
   
   var endsTime = 0
   
   var redTeamName = ""
   var blueTeamName = ""
   
   var redTeamFlagName = ""
   var blueTeamFlagName = ""
   
   var redTeamFinalScore = 0
   var blueTeamFinalScore = 0
   
   var redTeamPenaltyCount = 0
   var blueTeamPenaltyCount = 0
   
   var redTeamMedicalTimeOutCount = 0
   var blueTeamMedicalTimeOutCount = 0
   var redTeamTechnicalTimeOutCount = 0
   var blueTeamTechnicalTimeOutCount = 0
   
   var redTeamEndTimeRemaining = 0
   var blueTeamEndTimeRemaining = 0
   
   var redTeamPenaltiesScored = 0
   var blueTeamPenaltiesScored = 0
}
