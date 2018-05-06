//
//  FirebaseClient.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 5/6/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


class FirebaseClient  {
    
    static let shared = FirebaseClient()
    
    private var rootRef: DatabaseReference? = nil
    
    init() {
        if FirebaseApp.app() != nil {
            rootRef = Database.database().reference()
        } else {
            print("Firebase App is not configured yet.")
        }
        
    }
    
    func getAllUsers() {
        if let ref = rootRef {
            let userRef = ref.child("user")
            userRef.observe(.value, with: { snapshot in
                print(snapshot.value as Any)
            })
        } else {
            print("Could not get ref to database")
        }
    }
    
}
