//
//  WebhookViewController.swift
//  Surround
//
//  Created by Neil Goldader on 10/21/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import UIKit

class WebhookViewController: UIViewController {

    @IBOutlet weak var webhookKey: UITextField!
    @IBAction func save(_ sender: Any) {
        UserDefaults.standard.set(webhookKey.text ?? nil, forKey: "webhookKey")
        let alert = UIAlertController(title: "Woot!", message: "IFTTT Webhook Key saved! Feel free to proceed on to the main portion of the app :)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
