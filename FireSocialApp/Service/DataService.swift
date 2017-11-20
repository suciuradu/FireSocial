//
//  DataService.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 15/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = Database.database().reference()  //contine url de la baza noastra de date din firebase
let STORAGE_BASE = Storage.storage().reference()  // unde sunt pozele

class DataService {
    
    static let ds = DataService()  //Singleton Variable. O singura instanta, globala, accesibila de oriunde

    
    //DB reference
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    //Storage reference
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    //daca o sa vrem poze de profil, inca un folder cu pozele de profil
    
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS : DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT : DatabaseReference {  //determin userul curent
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    
    var REF_POST_IMAGES : StorageReference {
        return _REF_POST_IMAGES
    }
    
    func createFirebaseDBUser (uid: String, userData: Dictionary<String,String>) {    // creem userul sa il sticam in baza de date  (uid : idul, userData: providerul facebook,firebase etc.)
        _REF_USERS.child(uid).updateChildValues(userData)  // referinta la users, merge la userul cu id-ul uid si actualizeaza datele, sau nu le actualizeaza daca deja exista
    }
    
    
    
    
}
