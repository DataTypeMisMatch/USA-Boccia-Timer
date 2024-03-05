//
//  MainScreenViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 3/2/24.
//

import UIKit

class MainScreenViewController: UIViewController
{
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
	 // Do any additional setup after loading the view.
   }
   
   
   @IBAction func newMatch()
   {
      /*
      let controller = storyboard!.instantiateViewController(
	 withIdentifier: "MatchSettingsNavigationController")
      
      
      navigationController?.pushViewController(controller, animated: true)
       */
      
      let viewController: UIViewController = UIStoryboard(
	 name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MatchSettingsNavigationController")
      
      self.present(viewController, animated: true, completion: nil)
      
      
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
