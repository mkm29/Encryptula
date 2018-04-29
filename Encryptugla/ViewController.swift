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


class ViewController: UIViewController, FUIAuthDelegate {
    
    var authUI: FUIAuth?
    var encrypt: Encrypt?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.setupFirebase()
        //self.presentLogin()
        
        //self.encrypt = Encrypt()

        let nlp = GoogleLanguage()
        let textToAnaltze = "The financial crisis of 2008 hit many states hard, especially Kentucky. Since then, Kentucky has faced a large state deficit. It currently provides its public school teachers a retirement pension based on years of service, but the expense continues the deficit spending. Supporters of new legislation suggest teachers be required to shoulder some of the cost by contributing, similar to private sector employees. Opponents say changes in the law are broken promises and our teachers deserve more."
        
        nlp.analyzeSentiment(text: textToAnaltze) { (error, sentiments) in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            if let sentiments = sentiments {
                print("Total sentiments: ", sentiments.count)
                print(sentiments)
            }
        }
        
//        nlp.analyzeEntities(text: textToAnaltze) { (error, entities) in
//            guard error == nil else {
//                print(error?.localizedDescription)
//                return
//            }
//            if let entities = entities {
//                print("Total number of entities: ", entities.count)
//                for entity in entities {
//                    print(entity.name)
//                    if let wiki = entity.wikipediaURL {
//                        print(wiki)
//                    }
//                }
//            }
//        }
        
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
                print("Shoulld see loginVC")
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
            if let encrypt = self.encrypt {
                encrypt.uid = user.uid
            }
        }
    }

}

