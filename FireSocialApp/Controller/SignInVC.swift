//
//  SignInVC.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 10/10/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit
import Pastel

class SignInVC: UIViewController {

    @IBOutlet weak var pastelView: PastelView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("now works")
        
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight


        // Custom Duration
        pastelView.animationDuration = 10.0

        // Custom Color
        pastelView.setColors([#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) ])

        pastelView.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

