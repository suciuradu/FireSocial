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
       
        //pentru viitor cand voi scrie mail si parola, sa leg ultimul buton
        //din view de tastatura si sa se modifice odata cu ea
        pastelAnimation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pastelAnimation(){
        //Pastel amnimation
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        // Custom Duration
        pastelView.animationDuration = 3.0
        // Custom Color
        pastelView.setColors( [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)])
        pastelView.startAnimation()
    }


}

