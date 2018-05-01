//
//  Question.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/30/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation


struct Question {
    var qid: Int = 0
    var title: String = ""
    var affirmative: String?
    var negative: String?
    var description: String?
    
    init(fromJson json: [String:Any]) {
        if let qid = json["qid"] as? Int {
            self.qid = qid
        }
        if let title = json["title"] as? String {
            self.title = title
        }
        if let affirmative = json["affirmative"] as? String {
            self.affirmative = affirmative
        }
        if let negative = json["negative"] as? String {
            self.negative = negative
        }
        if let description = json["description"] as? String {
            self.description = description
        }
    }
}
