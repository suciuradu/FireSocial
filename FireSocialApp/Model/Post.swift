//
//  Post.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 17/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _caption : String!
    private var _imageUrl : String!
    private var _likes: Int!

    private var _postKey : String!
    private var _postRef : DatabaseReference!
    
    
    var postKey : String {
        return _postKey
    }
    var likes : Int {
        return _likes
    }
    var imageUrl : String {
        return _imageUrl
    }
    var caption : String {
        return _caption
    }
    
    init(caption: String, imageUrl: String, likes: Int) {
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String,Any> ) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        _postRef = DataService.ds.REF_POSTS.child(_postKey) //de aici, cand ajungem la referinta postarii, putem updata likeurile de la postarea curenta
        
    }
    
    
    func adjustLikes(addLike: Bool) {  //daca adaugam sau scadem la nr de likeuri in functie de bool addlike
        if addLike == true {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        _postRef.child("likes").setValue(_likes) //setam valoarea like-urilor de la post
    }
    

}














