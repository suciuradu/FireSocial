//
//  PostCell.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 09/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg : UIImageView!
    @IBOutlet weak var userLbl : UILabel!
    @IBOutlet weak var postImg : UIImageView!
    @IBOutlet weak var caption : UITextView!
    @IBOutlet weak var likes : UILabel!

    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(post:Post) {
        self.post = post
        self.caption.text = post.caption
        self.likes.text = "\(post.likes)"
    }
   

}
