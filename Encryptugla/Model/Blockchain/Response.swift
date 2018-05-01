//
//  Transaction.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/28/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation


class Response : Codable {
    
    // Question ID
    var qid: String
    
    // User ID
    var uid: String
    
    // textual representation of question response
    var text: String
    
    
    init(withQuestionId qid: String, andUserId uid: String, withAnswerText answer: String) {
        self.qid = qid
        self.uid = uid
        self.text = answer
    }
    
}
