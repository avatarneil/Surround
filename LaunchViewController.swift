//
//  LaunchViewController.swift
//  
//
//  Created by Neil Goldader on 10/20/18.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "gotoMain") {
            if (UserDefaults.standard.object(forKey: "apikey") == nil) {
                print("No API Key Found, please register.")
                let alert = UIAlertController(title: "Error: No API Key", message: "No API Key found, please complete registration.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }


}
