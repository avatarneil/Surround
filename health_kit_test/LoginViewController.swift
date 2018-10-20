//
//  LoginViewController.swift
//  health_kit_test
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
    @IBAction func submitAccessCode(_ sender: Any) {
        print(textf.text)
        net.httpPostRegister(input: textf.text ?? "0000")
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
