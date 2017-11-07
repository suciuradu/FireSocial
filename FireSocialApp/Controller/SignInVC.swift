//
//  SignInVC.swift
//  FireSocialApp
//
//  Created by Suciu Radu on 10/10/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit
import Pastel
import FacebookCore
import FacebookLogin
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import SkyFloatingLabelTextField

class SignInVC: UIViewController {

    @IBOutlet weak var pastelView: PastelView!
    
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //pentru viitor cand voi scrie mail si parola, sa leg ultimul buton
        //din view de tastatura si sa se modifice odata cu ea
        pastelAnimation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pastelAnimation(){
        //Pastel amnimation
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        // Custom Duration
        pastelView.animationDuration = 5.0
        // Custom Color
        pastelView.setColors( [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)])
        pastelView.startAnimation()
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: {(user, error) in
                if error == nil {
                    print("Suciu: Email signed in with Firebase")
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: {(user, error) in
                        if error != nil {
                            print("Suciu: Unable to auth to firebase with email")
                        } else {
                            print("Suciu: Succes to firebase with email")
                        }
                    })
                }
            })
        }
    }
    
    
    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result,error) in
            if error != nil {
                print("Suciu : Unable to authentificate with Facebook")
            } else if result?.isCancelled == true {
                print ("Suciu : user canceled authent")
            } else {
                print("Suciu: Facebook auth Succes!")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if (error != nil) {
                print("Suciu : Unable to sign in with firebase")
            } else {
                print("Suciu : Sucessful sign in with firebase")
            }
        }
    }

}

