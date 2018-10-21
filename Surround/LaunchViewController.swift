//
//  LaunchViewController.swift
//  Surround
//
//  Created by Neil Goldader on 10/20/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import UIKit
import Foundation

class LaunchViewController: UIViewController {
    override func viewDidLoad() {
        print("hello")
        print(UserDefaults.standard.object(forKey: "apikey")!)
    }
}
