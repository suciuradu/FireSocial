//
//  CircleView.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 09/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
        
        layer.cornerRadius = self.frame.width / 2
    }

}
