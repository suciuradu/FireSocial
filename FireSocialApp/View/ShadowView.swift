//
//  ShadowView.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 09/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 12
    }

}
