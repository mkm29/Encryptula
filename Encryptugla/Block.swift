//
//  Block.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/24/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//
import Foundation

class Block {
    
    var index :Int = 0
    var dateCreated :String
    var previousHash :String!
    var hash :String!
    var nonce :Int
    var data :String
    
    var key :String {
        get {
            return String(self.index) + self.dateCreated + self.previousHash + self.data + String(self.nonce)
        }
    }
    
    init(data :String) {
        self.dateCreated = Date().toString(dateFormat: "MM-dd-yyyy HH:mm")
        self.nonce = 0
        self.data = data
    }
    
    
}
