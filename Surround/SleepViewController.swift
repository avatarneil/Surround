//
//  SleepViewController.swift
//  Surround
//
//  Created by Neil Goldader on 10/21/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import UIKit


class SleepViewController: UIViewController {

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
        super.touchesEnded(touches as! Set<UITouch>, with: event)
    }
    
    @IBOutlet weak var text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        self.text.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.text.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    override var prefersHomeIndicatorAutoHidden : Bool { return true }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
