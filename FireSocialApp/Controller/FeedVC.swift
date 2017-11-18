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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var centerYPopUpConstraint: NSLayoutConstraint!   //pentru animatia PostView care vine de jos
    @IBOutlet weak var captionField: UITextView!
    @IBOutlet weak var postView: RoundedView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var addImagePicked: UIImageView! // care se pune cand apasam selectam imaginea din poze pe care o postam
    
    var postsArray = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageChace : NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            self.postsArray = [Post]() // cand schimbam ceva, sa nu existe duplicate in array, il reinitializam gol (NEEFICIENT!!) nu stiu altfel
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.postsArray.insert(post, at:0)
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
        
        let post = postsArray[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            if let img = FeedVC.imageChace.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post, img: nil)
                return cell
            }
        } else {
            return PostCell()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImagePicked.image = image
        } else {
            print("Suciu: Not a valid image selected")
        }
        imagePicker.dismiss(animated: true , completion: nil)  //selectam imaginea din poze
    }

    //postez in Storage imaginea pe care o selectez (apas butonul de poza si cand apas ala verde postez in storage poza apoi apelez functia de postare in firebase)
    @IBAction func addPostBtnPressed(_ sender: Any) {
        guard let caption = captionField.text, caption != "" else {
            print("Suciu: Caption must be entered")
            return
        }
        guard let img = addImagePicked.image else {
            print("Suciu: An image must be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
        
            DataService.ds.REF_POST_IMAGES.child(imgUid).putData(imgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("Suciu: Unable to upload image to Firebase")
                } else {
                    print("Suciu: Succesfully uploaded to Firebase")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    self.postToFirebase(imgUrl: downloadURL!) //functie de postare a postului in firebase
                    self.view.endEditing(true) // inchide tastatura
                }
            }
        }
        
    }
    
    @IBAction func addImagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
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
        
        self.view.endEditing(true) //inchide tastatura daca am apasat pe text
    }
    
    //generam un id pentru post si il adaugam in baza de date
    func postToFirebase(imgUrl: String) {
        let post: Dictionary<String, Any> = [
            "caption" : captionField.text,
            "imageUrl" : imgUrl,
            "likes" : 0
        ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        captionField.text = ""
        addImagePicked.image = UIImage(named: "addPost")
        closeBtnPressed(self)
        
    }
    
}















