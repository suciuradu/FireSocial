//
//  FeedVC.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 07/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var centerYPopUpConstraint: NSLayoutConstraint!   //pentru animatia PostView care vine de jos
    @IBOutlet weak var postView: RoundedView!
    @IBOutlet weak var blurView: UIView!
    
    var postsArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.postsArray.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }

  
    //cand dau sign out, sterge cheia acc ca atunci cand intrii in aplicatie sa nu te bage direct in feed
    @IBAction func signOutBtnPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Suciu : Removed from keychain")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    
    //apas butonul de post si apare view-ul de jos
    @IBAction func postBtnPressed(_ sender: Any) {
        
        //nu uita sa setezi Y constrint de la postView pe 630
        self.centerYPopUpConstraint.constant = 600
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            self.blurView.alpha = 0.55
            self.centerYPopUpConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    //apas putonul close ca sa mearga inapoi jos view-ul
    @IBAction func closeBtnPressed(_ sender: Any) {
        
        //nu uita sa setezi Y constrint de la postView pe 630
        self.centerYPopUpConstraint.constant = 0
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            self.blurView.alpha = 0
            self.centerYPopUpConstraint.constant = 600
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
