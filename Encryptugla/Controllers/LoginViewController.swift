//
//  ViewController.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/23/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FirebasePhoneAuthUI


class LoginViewController: UIViewController, FUIAuthDelegate {
    
    var authUI: FUIAuth?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupFirebase()
        self.presentLogin()
    }
    
    private func setupFirebase() {
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth(),
            FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
            ]
        self.authUI?.providers = providers
    }
    
    private func setup() {
        
    }
    
    
    private func presentLogin() {
        guard let authVC = self.authUI else {
            print("Must instantiate authUI first!")
            return
        }
        let authViewController = authVC.authViewController()
        DispatchQueue.main.async {
            self.present(authViewController, animated: true, completion: {
                print("Should see loginVC")
            })
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FirebaseAuth.User?, error: Error?) {
        // handle user and error as necessary
        guard error == nil else {
            print("Unable to login: %@", error?.localizedDescription)
            return
        }
        if let user = user {
            print("Logged in as uid: %@", user.uid)
            // set the user in Coordinator
            Coordinator.shared.user = user
            self.performSegue(withIdentifier: "showQuestionsFromLogin", sender: nil)
        }
    }

}

