//
//  User.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 5/6/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

struct User: Codable {
    
    let user_id: String
    let first_name: String
    let last_name: String
    let email: String
    let phone: String
    let image: String
    var isUserBlocked: String
    var isUserDeleted: String
    
}
