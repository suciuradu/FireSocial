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
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }

}
