//
//  MatchItem.swift
//  USA Boccia Timer
//
//  Created by Fox on 1/13/24.
//

import Foundation
import UIKit

class MatchItem
{
   var gameName = ""
   
   var redTeamName = ""
   var blueTeamName = ""
   var usaFlag = UIImage(named: "USA_Flag")
   
   var kind = ""
   var playType = ""
   var classification = ""
   
   var numEnds = 4
   var times: UIDatePicker!
}

