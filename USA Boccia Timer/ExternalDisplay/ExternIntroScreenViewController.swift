//
//  ExternIntroScreenViewController.swift
//  USA Boccia Timer
//
//  Created by Raasikh Kanjiani on 4/30/24.
//

import Foundation
import UIKit

class ExternIntroScreenViewController: UIViewController {
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(showScoreboard(_:)), name: Notification.Name("ShowScoreboard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissScoreboard(_:)), name: Notification.Name("ShowIntroScreen"), object: nil)
    }
    
    @objc func showScoreboard(_ notification: Notification) {
        performSegue(withIdentifier: "scoreboardSegue", sender: self)
    }
    @objc func dismissScoreboard(_ notification: Notification) {
        dismiss(animated: true)
    }
}
