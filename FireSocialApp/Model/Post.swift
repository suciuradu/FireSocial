//
//  Post.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 17/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import Foundation


class Post {
    private var _caption : String!
    private var _imageUrl : String!
    private var _likes: Int!

    private var _postKey : String!
    
    
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
        
        
        
    }
    
    

}
