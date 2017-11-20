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
    @IBOutlet weak var likeImg: UIImageView!
    
    var post: Post!
    var likeRef : DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likePressed)) //creaza tap
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap) //adaugam tap recognizer la imaginea cu inima
        likeImg.isUserInteractionEnabled = true
        
    }

    
    func configureCell(post:Post, img: UIImage? ) {
        self.post = post
        likeRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
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
        //cand se creeaza celula, observa daca are like sau nu
        likeRef.observeSingleEvent(of: .value, with: { (snapshot) in  //observam un singur eveniment, cand se creeaza postul, daca este like sau nu
            if let _ = snapshot.value as? NSNull { //firebase are null nu nil. daca nu exista like returneaza null
                self.likeImg.image = UIImage(named: "empty-heart")
            } else {
                self.likeImg.image = UIImage(named: "filled-heart")  //daca exista like o setam cu imaginea de inima filled
            }
        })
        
    }
    
    @objc func likePressed(sender: UITapGestureRecognizer) {
        likeRef.observeSingleEvent(of: .value, with: { (snapshot) in  //observam un singur eveniment, cand se creeaza postul, daca este like sau nu
            if let _ = snapshot.value as? NSNull { // DACA NU ARE LIKE, CAND APASAM FACEM LIKE
                self.likeImg.image = UIImage(named: "filled-heart") //aici
                self.post.adjustLikes(addLike: true)
                self.likeRef.setValue(true) //daca a dat like, setam referinta la acel post ca fiind true, adica a dat like
            } else {
                self.likeImg.image = UIImage(named: "filled-heart")  //DACA ARE DEJA LIKE, CAND APASAM -> NU MAI E LIKE
                self.post.adjustLikes(addLike: false)
                self.likeRef.removeValue() //daca da unlike, sterge referinta
            }
        })
    }

}































