//
//  LoginViewController.swift
//  Surround
//
//  Created by Neil Goldader on 10/20/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var net = NetworkLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var textf: UITextField!
    @IBAction func submitAccessCode(_ sender: UIButton) {
        // print(textf.text)
        if (sender.tag == 0) {
            net.httpPostRegister(input: textf.text ?? "0000", onSuccess: self.loginStatus)
        }
    }
    
    func loginStatus(state: Bool) {
        if (state) {
            let alert = UIAlertController(title: "Woot!", message: "Successfully Authenticated! Proceed to the dashboard!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "This is the best day of my life!", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: ":(", message: "You failed to authenticate. Time to go cry yourself to sleep :'(", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "This is the worst day of my life :'(", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
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
