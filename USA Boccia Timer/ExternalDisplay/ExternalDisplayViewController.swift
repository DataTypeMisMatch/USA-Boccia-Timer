//
//  ExternalDisplayViewController.swift
//  USA Boccia Timer
//
//  Created by Raasikh Kanjiani on 3/13/24.
//

import UIKit

class ExternalDisplayViewController: UIViewController {
    
    @IBOutlet var redView: UIView?
    @IBOutlet var endsView: UIView?
    @IBOutlet var blueView: UIView?
    @IBOutlet var mainView: UIView?
    @IBOutlet var redNameLabel: UILabel?
    @IBOutlet var blueNameLabel: UILabel?
    @IBOutlet var redScoreLabel: UILabel?
    @IBOutlet var blueScoreLabel: UILabel?
    @IBOutlet var blueBallsStack: UIStackView?
    @IBOutlet var redBallsStack: UIStackView?
    @IBOutlet var endsStack: UIStackView? // create array to accomodate tiebreakers
    @IBOutlet var redTimerLabel: UILabel?
    @IBOutlet var blueTimerLabel: UILabel?
    
    var label5thEnd: UIView?
    var label6thEnd: UIView?
    var currentEnd = 1
    var allEndsViews: [UIView]? = []
    var currEndsCount = 6
    var winnerScreenRedScore = "0"
    var winnerScreenBlueScore = "0"
    var winnerTeamName = "Red"
    var currTieBreaker = 0
    var timerTeamName = "Red"
    var timerName = "Timeout"
    var redBallImages = UIStackView()
    var blueBallImages = UIStackView()
    var firstTime = 1
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // screenWidth = Int(view.bounds.width)
        // screenHeight = Int(view.bounds.height)

        /*
        redView!.trailingAnchor.constraint(equalTo: blueView!.leadingAnchor, constant: view.bounds.width/2).isActive = true
        redView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:0).isActive = true
        
        blueView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:0).isActive = true
        blueView!.leadingAnchor.constraint(equalTo: redView!.leadingAnchor, constant: view.bounds.width/2).isActive = true
        */
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up design for timers
        redTimerLabel?.layer.borderWidth = 2
        blueTimerLabel?.layer.borderWidth = 4
        redTimerLabel?.layer.borderColor = CGColor(red: 255.0, green: 0, blue: 0, alpha: 1.0)
        blueTimerLabel?.layer.borderColor = CGColor(red: 0, green: 0, blue: 255.0, alpha: 1.0)
        
        // Add observers for notifications
        NotificationCenter.default.addObserver(self, selector: #selector(updateRedName(_:)), name: Notification.Name("NewRedName"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBlueName(_:)), name: Notification.Name("NewBlueName"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateRedScore(_:)), name: Notification.Name("NewRedScore"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBlueScore(_:)), name: Notification.Name("NewBlueScore"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(incrementRedBalls(_:)), name: Notification.Name("IncrementRedBalls"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(incrementBlueBalls(_:)), name: Notification.Name("IncrementBlueBalls"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(decrementRedBalls(_:)), name: Notification.Name("DecrementRedBalls"), object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(decrementBlueBalls(_:)), name: Notification.Name("DecrementBlueBalls"), object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(changeTotalEndsTo(_:)), name: Notification.Name("ChangeTotalEndsTo"), object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(nextEnd(_:)), name: Notification.Name("NextEnd"), object: nil)
//        NotificationCenter.default.addObserver(self, selector:  #selector(changeEndTo(_:)), name: Notification.Name("ChangeEndTo"), object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(newTiebreakerEnd(_:)), name: Notification.Name("NewTiebreakerEnd"), object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(setRedTimer(_:)), name: Notification.Name("SetRedTimer"), object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(setBlueTimer(_:)), name: Notification.Name("SetBlueTimer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showTeamSpecificTimer(_:)), name: Notification.Name("ShowTeamSpecificTimer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showNonTeamSpecificTimer(_:)), name: Notification.Name("ShowNonTeamSpecificTimer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showWinner(_:)), name: Notification.Name("ShowWinner"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearScoreboard(_:)), name: Notification.Name("ClearScoreboard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissExtern(_:)), name: Notification.Name("DismissTimer"), object: nil)
        
        // Start off with a default of 4 ends
        NotificationCenter.default.post(name: Notification.Name("ChangeTotalEndsTo"), object: nil, userInfo: ["message": 4])

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "teamSpecificTimerSegue" {
            if let destinationVC = segue.destination as? ExternTeamSpecificTimerViewController {
                destinationVC.redName = redNameLabel?.text ?? "Red Team Name"
                destinationVC.blueName = blueNameLabel?.text ?? "Blue Team Name"
                destinationVC.teamName = timerTeamName // pass objects here for consistency
                destinationVC.timerName = timerName
            }
        }
        
        if segue.identifier == "nonTeamSpecificTimerSegue" {
            if let destinationVC = segue.destination as? ExternNonTeamSpecificTimerViewController {
                destinationVC.redName = redNameLabel?.text ?? "Red Team Name"
                destinationVC.blueName = blueNameLabel?.text ?? "Blue Team Name"
                destinationVC.timerName = timerName
            }
        }

        if segue.identifier == "winnerSegue" {
            if let destinationVC = segue.destination as? ExternWinnerViewController {
                destinationVC.redName = redNameLabel?.text ?? "Red Team Name"
                destinationVC.blueName = blueNameLabel?.text ?? "Blue Team Name"
                destinationVC.redScore = winnerScreenRedScore
                destinationVC.blueScore = winnerScreenBlueScore
                destinationVC.winner = winnerTeamName
                
            }
        }

    }
    
    @objc func updateRedName(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let newName = userInfo["message"] as? String {
                redNameLabel?.text = newName
/*
-----------------------------TESTING-------------------------------------------------------------------------
                NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": "99:99"])
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    NotificationCenter.default.post(name: Notification.Name("DismissTimer"), object: nil, userInfo: ["message": " "])
                    NotificationCenter.default.post(name: Notification.Name("SetRedTimer"), object: nil, userInfo: ["message": "99:99"])
                    NotificationCenter.default.post(name: Notification.Name("SetBlueTimer"), object: nil, userInfo: ["message": "99:99"])
                    NotificationCenter.default.post(name: Notification.Name("ChangeTotalEndsTo"), object: nil, userInfo: ["message": 4])
                    NotificationCenter.default.post(name: Notification.Name("NewRedScore"), object: nil, userInfo: ["message": "99"])
                    NotificationCenter.default.post(name: Notification.Name("NewBlueScore"), object: nil, userInfo: ["message": "99"])
                    NotificationCenter.default.post(name: Notification.Name("DecrementRedBalls"), object: nil, userInfo: ["message": " "])
                    NotificationCenter.default.post(name: Notification.Name("DecrementBlueBalls"), object: nil, userInfo: ["message": " "])
                    NotificationCenter.default.post(name: Notification.Name("DecrementRedBalls"), object: nil, userInfo: ["message": " "])
                    NotificationCenter.default.post(name: Notification.Name("DecrementBlueBalls"), object: nil, userInfo: ["message": " "])
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                    NotificationCenter.default.post(name: Notification.Name("ShowNonTeamSpecificTimer"), object: nil, userInfo: ["message": "Warmup and Tiebreaker Timer"])
                    NotificationCenter.default.post(name: Notification.Name("SetExternTimeoutTimer"), object: nil, userInfo: ["message": "99:99"])
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 18) {
                    NotificationCenter.default.post(name: Notification.Name("DismissTimer"), object: nil, userInfo: ["message": " "])
                    NotificationCenter.default.post(name: Notification.Name("IncrementRedBalls"), object: nil, userInfo: ["message": " "])
                    NotificationCenter.default.post(name: Notification.Name("IncrementBlueBalls"), object: nil, userInfo: ["message": " "])
                    NotificationCenter.default.post(name: Notification.Name("IncrementRedBalls"), object: nil, userInfo: ["message": " "])
                    NotificationCenter.default.post(name: Notification.Name("IncrementBlueBalls"), object: nil, userInfo: ["message": " "])
                    NotificationCenter.default.post(name: Notification.Name("NextEnd"), object: nil, userInfo: ["message": ""])
                    NotificationCenter.default.post(name: Notification.Name("NextEnd"), object: nil, userInfo: ["message": ""])
                    NotificationCenter.default.post(name: Notification.Name("NextEnd"), object: nil, userInfo: ["message": ""])
                    NotificationCenter.default.post(name: Notification.Name("NewTiebreakerEnd"), object: nil, userInfo: ["message": ""])
                    NotificationCenter.default.post(name: Notification.Name("NewTiebreakerEnd"), object: nil, userInfo: ["message": ""])
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 24) {
                    NotificationCenter.default.post(name: Notification.Name("ShowWinner"), object: nil, userInfo: ["message": ["5", "9", "blue"]])
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                    NotificationCenter.default.post(name: Notification.Name("DismissTimer"), object: nil, userInfo: ["message": ""])
                }
*/
            }
        }
    }
    
    @objc func updateBlueName(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let newName = userInfo["message"] as? String {
                blueNameLabel?.text = newName
            }
        }
    }
    
    @objc func updateRedScore(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let newScore = userInfo["message"] as? String {
                redScoreLabel?.text = newScore
            }
        }
    }
    
    @objc func updateBlueScore(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let newScore = userInfo["message"] as? String {
                blueScoreLabel?.text = newScore
            }
        }
    }
    
    @objc func incrementRedBalls(_ notification: Notification) {
            // Handle the notification
        if notification.userInfo != nil {
            
            for subview in redBallsStack!.arrangedSubviews.reversed() {
                if subview.isHidden == true {
                    subview.isHidden = false
                    return
                }
            }

        }
    }
    
    @objc func incrementBlueBalls(_ notification: Notification) {
            // Handle the notification
        if notification.userInfo != nil {
            for subview in blueBallsStack!.arrangedSubviews.reversed() {
                if subview.isHidden == true {
                    subview.isHidden = false
                    return
                }
            }
        }
    }
    
    @objc func decrementRedBalls(_ notification: Notification) {
        // Handle the notification
        if notification.userInfo != nil {
            for subview in redBallsStack!.arrangedSubviews.reversed() {
                if subview.isHidden == false {
                    subview.isHidden = true
                    return
                }
            }
        }
    }

   //Try out Dimming Red balls instead of Removing Them
    @objc func dimRedBalls(_ notification: Notification) {
        // Handle the notification
        if notification.userInfo != nil {
            for subview in redBallsStack!.arrangedSubviews.reversed() {
                if subview.isHidden == false {
                    subview.isHidden = true
                    return
                }
            }
        }
    }


    @objc func decrementBlueBalls(_ notification: Notification) {
        // Handle the notification
        if notification.userInfo != nil {
            for subview in blueBallsStack!.arrangedSubviews.reversed() {
                if subview.isHidden == false {
                    subview.isHidden = true
                    return
                }
            }
        }
    }
   
   //Try out dimming Blue Balls instead of Dimming them

       @objc func dimBlueBalls(_ notification: Notification) {
        // Handle the notification
        if notification.userInfo != nil {
            for subview in blueBallsStack!.arrangedSubviews.reversed() {
                if subview.isHidden == false {
                    subview.isHidden = true
                    return
                }
            }
        }
    }

   
   
    @objc func changeTotalEndsTo(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let newNumOfEnds = userInfo["message"] as? Int {
                
                // Exit if wrong input
                if (newNumOfEnds == 0 || newNumOfEnds > 6) {
                    return
                }
                
                // Save all the ends labels for later use (this will only happen once)
                if (currEndsCount == 6 && firstTime == 1) {
                    firstTime = 0
                    for i in 0..<6 {
                        allEndsViews?.append(endsStack!.arrangedSubviews[i])
                    }
                }
                
                // do nothing if the num of ends visible are equal to requested num of ends
                // if requested num of ends > curr ends add the needed end labels to stack
                // if requested num of ends < curr ends remove the difference num of labels
                if (newNumOfEnds == currEndsCount) {
                    return
                } else if (newNumOfEnds > currEndsCount) {
                    for i in 0..<newNumOfEnds - currEndsCount {
                        let newTieEndLabel = allEndsViews![currEndsCount + i] as! UILabel
                        
                        endsStack?.addArrangedSubview(newTieEndLabel)
                        
                        // Set constraints to be adaptable to screensize
                        
                        // Set width constraint with multiplier relative to the 3rd end label
                        // (explaination is below)
                        newTieEndLabel.translatesAutoresizingMaskIntoConstraints = false
                        let widthConstraint = NSLayoutConstraint(item: newTieEndLabel,
                                                                 attribute: .width,
                                                                 relatedBy: .equal,
                                                                 toItem: endsStack?.arrangedSubviews[2],
                                                                 attribute: .width,
                                                                 multiplier: 1,
                                                                 constant: 0)
                        widthConstraint.priority = .required // Priority 1000
                        endsStack!.addConstraint(widthConstraint)

                        // Set height constraint with multiplier relative to the 3rd end label
                        // because it needs to be endsstack or subview of it and endsstack size
                        // changes progressively, ruining size of tiebreaker end label
                        let heightConstraint = NSLayoutConstraint(item: newTieEndLabel,
                                                                  attribute: .height,
                                                                  relatedBy: .equal,
                                                                  toItem: endsStack?.arrangedSubviews[2],
                                                                  attribute: .height,
                                                                  multiplier: 1,
                                                                  constant: 0)
                        heightConstraint.priority = .required // Priority 1000
                        endsStack!.addConstraint(heightConstraint)
                        
                        newTieEndLabel.minimumScaleFactor = 0.01
                        newTieEndLabel.adjustsFontSizeToFitWidth = true

                        newTieEndLabel.font = UIFont.systemFont(ofSize: 500)
                        
                    }
                    currEndsCount = newNumOfEnds
                } else {
                    for _ in 1...currEndsCount - newNumOfEnds {
                        endsStack!.arrangedSubviews.last!.removeFromSuperview()
                    }
                    currEndsCount = newNumOfEnds
                }
            }
        }
    }
    
    @objc func nextEnd(_ notification: Notification) {
        // exit if bad input
        if (currentEnd == currEndsCount) {
            return
        }
        
        // Handle the notification
        if notification.userInfo != nil {
            
            if let newEndLabel = endsStack?.arrangedSubviews[currentEnd] as? UILabel {
                if let currEndLabel = endsStack?.arrangedSubviews[currentEnd-1] as? UILabel {
                    // highlight new end
                    newEndLabel.font = currEndLabel.font
                    newEndLabel.textAlignment = currEndLabel.textAlignment
                    newEndLabel.backgroundColor = currEndLabel.backgroundColor
                    newEndLabel.font = currEndLabel.font.withSize(currEndLabel.font.pointSize)
                    newEndLabel.frame = currEndLabel.frame
                    
                    // Make curr end normal
                    currEndLabel.font = UIFont.systemFont(ofSize: currEndLabel.font.pointSize, weight: .regular)
                    currEndLabel.backgroundColor = .darkGray
                }
            }
            
            currentEnd += 1
        }
    }
 
    // I do not believe that this will be useful
/*
    @objc func changeEndTo(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let newEndNum = userInfo["message"] as? Int {
                // exit if bad input
                if (newEndNum > 6 || newEndNum < 1) {
                    return
                }
                
                // make current end normal
                if let currEndLabel = endsStack?.arrangedSubviews[currentEnd-1] as? UILabel {
                    currEndLabel.font = UIFont.systemFont(ofSize: 54, weight: .regular)
                    currEndLabel.backgroundColor = .darkGray
                }
                // highlight new end
                if let newEndLabel = endsStack?.arrangedSubviews[newEndNum-1] as? UILabel {
                    newEndLabel.font = UIFont.systemFont(ofSize: 64, weight: .bold)
                    newEndLabel.backgroundColor = .white
                }
                currentEnd = newEndNum
            }
        }
    }
*/
    
    @objc func newTiebreakerEnd(_ notification: Notification) {
        if (currentEnd != currEndsCount) {
            return
        }
        
        // make the new tiebreaker label
        let newTieEndLabel = UILabel()
        newTieEndLabel.text = "Tiebreaker " + String(currTieBreaker + 1)
        
        // highlight new tie breaker end and normalize curr end
        if let currEndLabel = endsStack?.arrangedSubviews[currentEnd-1] as? UILabel {
            // highlight new tiebreaker
            newTieEndLabel.font = currEndLabel.font
            newTieEndLabel.textAlignment = currEndLabel.textAlignment
            newTieEndLabel.backgroundColor = currEndLabel.backgroundColor
            newTieEndLabel.font = currEndLabel.font.withSize(40)
            newTieEndLabel.frame = currEndLabel.frame
            
            // show new tiebreaker on screen
            endsStack?.addArrangedSubview(newTieEndLabel)
            
            // Set constraints to be adaptable to screensize
            
            // Set width constraint with multiplier relative to the 3rd end label
            // (explaination is below)
            newTieEndLabel.translatesAutoresizingMaskIntoConstraints = false
            let widthConstraint = NSLayoutConstraint(item: newTieEndLabel,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: endsStack?.arrangedSubviews[2],
                                                     attribute: .width,
                                                     multiplier: 2.6,
                                                     constant: 0)
            widthConstraint.priority = .required // Priority 1000
            endsStack!.addConstraint(widthConstraint)

            // Set height constraint with multiplier relative to the 3rd end label
            // because it needs to be endsstack or subview of it and endsstack size
            // changes progressively, ruining size of tiebreaker end label
            let heightConstraint = NSLayoutConstraint(item: newTieEndLabel,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: endsStack?.arrangedSubviews[2],
                                                      attribute: .height,
                                                      multiplier: 1,
                                                      constant: 0)
            heightConstraint.priority = .required // Priority 1000
            endsStack!.addConstraint(heightConstraint)

            newTieEndLabel.minimumScaleFactor = 0.01
            newTieEndLabel.adjustsFontSizeToFitWidth = true

            newTieEndLabel.font = UIFont.boldSystemFont(ofSize: 500)
            
            // make curr end normal
            currEndLabel.font = UIFont.systemFont(ofSize: currEndLabel.font.pointSize, weight: .regular)
            currEndLabel.backgroundColor = .darkGray
            
        }
        
        // update internal record
        currentEnd += 1
        currEndsCount += 1
        currTieBreaker += 1
        
        if currTieBreaker > 3 {
            let initEnds = currentEnd - currTieBreaker
            let i = initEnds + currTieBreaker-3-1
            endsStack!.arrangedSubviews[i].isHidden = true
            let label = endsStack!.arrangedSubviews[i+1] as! UILabel
            label.text = "..." + label.text!
            
        }
    }
    
    @objc func setRedTimer(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let newTime = userInfo["message"] as? String {
                redTimerLabel?.text = newTime
            }
        }
    }
    
    @objc func setBlueTimer(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let newTime = userInfo["message"] as? String {
                blueTimerLabel?.text = newTime
            }
        }
    }
    
    
    // Expects a string array like: ["Medical Timeout", "Blue"]
    // The first element is the title of the timer screen and the
    // second is the team name like Blue Team's Medical Timeout
    @objc func showTeamSpecificTimer(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let timerInfo = userInfo["message"] as? [String] {
                timerName = timerInfo[0].capitalized
                timerTeamName = timerInfo[1].capitalized
                performSegue(withIdentifier: "teamSpecificTimerSegue", sender: self)
            }
        }
    }
    
    // Expects the timer name as input
    @objc func showNonTeamSpecificTimer(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let timerName = userInfo["message"] as? String {
                self.timerName = timerName.capitalized
                
                // if its a tiebreaker show the number of the tiebreaker
                if (self.timerName == "Tiebreaker") {
                    self.timerName = self.timerName + " " + String(currTieBreaker)
                }
                else if (self.timerName == "New End") {
                    if (currTieBreaker == 0) {
                        self.timerName = self.timerName + " " + String(currentEnd)
                    } else {
                        self.timerName = "New Tiebreaker End " + String(currTieBreaker)
                    }
                    
                }
                
                performSegue(withIdentifier: "nonTeamSpecificTimerSegue", sender: self)
            }
        }
    }
    
    // Expects input: ["redScore", "blueScore"]
    // Can be adapted to show any past or current match results by changing
    // input to: ["redName", "blueName", "redScore", "blueScore"]
    @objc func showWinner(_ notification: Notification) {
        // Handle the notification
        if let userInfo = notification.userInfo {
            // Access userInfo if any
            if let winnerInfo = userInfo["message"] as? [String] {
                winnerScreenRedScore = winnerInfo[0]
                winnerScreenBlueScore = winnerInfo[1]
                if Int(winnerScreenRedScore)! > Int(winnerScreenBlueScore)! {
                    winnerTeamName = "Red"
                } else {
                    winnerTeamName = "Blue"
                }
                performSegue(withIdentifier: "winnerSegue", sender: self)
            }
        }
    }
    
    // If message is "HardReset", reset ends and scores and timers and everything else
    // else if message is "", reset everything except for ends and scores and timers
    @objc func clearScoreboard(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let resetString = userInfo["message"] as? String {
                // Clear Red Balls
                for subview in redBallsStack!.arrangedSubviews.reversed() {
                    subview.isHidden = false
                }
                // Clear Blue Balls
                for subview in blueBallsStack!.arrangedSubviews.reversed() {
                    subview.isHidden = false
                }
                
                if resetString == "HardReset" {
                    // reset internal records of ends
                    if currTieBreaker != 0 {
                        currEndsCount = currentEnd - currTieBreaker
                    }
                    currentEnd = 1
                    currTieBreaker = 0
                    
                    // reset to 4 total ends
                    for i in (currEndsCount..<endsStack!.arrangedSubviews.count).reversed() {
                        endsStack!.arrangedSubviews[i].removeFromSuperview()
                    }
                    
                    // normalize the look of all ends
                    for view in endsStack!.arrangedSubviews {
                        if let currEndLabel = view as? UILabel {
                            currEndLabel.font = UIFont.systemFont(ofSize: currEndLabel.font.pointSize)
                            currEndLabel.backgroundColor = .darkGray
                        }
                    }
                    
                    // highlight first end only
                    if let currEndLabel = endsStack!.arrangedSubviews[0] as? UILabel {
                        currEndLabel.font = UIFont.boldSystemFont(ofSize: currEndLabel.font.pointSize)
                        currEndLabel.backgroundColor = .white
                    }
                    
                    // Reset scores
                    redScoreLabel!.text = "0"
                    blueScoreLabel!.text = "0"
                    
                    // Reset timers
                    redTimerLabel!.text = "00:00"
                    blueTimerLabel!.text = "00:00"
                }
                
            }
        }
    }
    
    @objc func dismissExtern(_ notification: Notification) {
        // Handle the notification
        if notification.userInfo != nil {
                dismiss(animated: true)
        }
    }

    deinit {
        // Remove observer when view controller is deallocated
        NotificationCenter.default.removeObserver(self)
    }
}
