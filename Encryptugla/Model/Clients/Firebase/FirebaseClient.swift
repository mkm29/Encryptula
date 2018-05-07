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
    
    func getAllUsers(completion: @escaping (_ error: Error?, _ users: [User]?) -> Void) {
        if let ref = rootRef {
            ref.child("user").observeSingleEvent(of: .value, with: { snapshot in
                // need to loop over users(children) and create User struct objects
                if let children = snapshot.children.allObjects as? [DataSnapshot] {
                    // init users array
                    var users: [User] = [User]()
                    for snap in children {
                        if let userDict = snap.value as? Dictionary<String, String>, let json = try? JSONEncoder().encode(userDict), let user = try? JSONDecoder().decode(User.self, from: json) {
                            // see if we can create users
                            users.append(user)
                        } else {
                            print("Unable to convert to dict")
                        }
                    }
                    completion(nil, users)
                } else {
                    let error = NSError(domain: "Unable to get snapshot from Firebase", code: 1, userInfo: nil)
                    completion(error, nil)
                }
            })
        }
    }
    
}
