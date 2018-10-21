//
//  UIStoryboardSegueFromTop.swift
//  Surround
//
//  Created by Neil Goldader on 10/20/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import UIKit

class UIStoryboardSegueFromTop: UIStoryboardSegue {
    override func perform() {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: 0, y: -src.view.frame.size.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }) { (Finished) in
            src.present(dst, animated: false, completion: nil)
        }
    }
}
