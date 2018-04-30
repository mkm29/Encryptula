//
//  Coordinator.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/29/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Firebase
import FirebaseAuth


class Coordinator {
    
    static let shared = Coordinator()
    
    var user: FirebaseAuth.User?
    let nlp: GoogleLanguage = GoogleLanguage()
    let encrypt: Encrypt = Encrypt()
    
    
}
