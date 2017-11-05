//
//  RoundButton.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 05/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:1.0, height: 1.0)
        
        layer.cornerRadius = 5.0
        
    }
    
}
