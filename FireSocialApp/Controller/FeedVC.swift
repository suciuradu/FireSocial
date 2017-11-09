//
//  FeedVC.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 07/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    @IBOutlet weak var centerYPopUpConstraint: NSLayoutConstraint!

    @IBOutlet weak var postView: RoundedView!
    @IBOutlet weak var blurView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    @IBAction func postBtnPressed(_ sender: Any) {
        
        //nu uita sa setezi Y constrint de la postView pe 630
        self.centerYPopUpConstraint.constant = 630
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            self.blurView.alpha = 0.55
            self.centerYPopUpConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        
        //nu uita sa setezi Y constrint de la postView pe 630
        self.centerYPopUpConstraint.constant = 0
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            self.blurView.alpha = 0
            self.centerYPopUpConstraint.constant = 630
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
