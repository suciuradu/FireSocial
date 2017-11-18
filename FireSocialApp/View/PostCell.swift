//
//  PostCell.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 09/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit
import Firebase

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

    
    func configureCell(post:Post, img: UIImage? ) {
        self.post = post
        self.caption.text = post.caption
        self.likes.text = "\(post.likes)"
        
        //setam imaginea din cache, daca exista, ca imgPost, daca nu, o downloadam
        if img != nil {
            self.postImg.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.imageUrl) //de aici luam imaginea
            ref.getData(maxSize: 2 * 1024 * 1024 , completion: {(data,error) in
                if error != nil {
                    print("Suciu: Unable to download image from storage")
                } else {
                    print("Suciu: Image downloaded from storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageChace.setObject(img, forKey: post.imageUrl as NSString) // downloadam imaginea si o salvam pe cache
                        }
                    }
                }
            })
        }
    }
   

}
