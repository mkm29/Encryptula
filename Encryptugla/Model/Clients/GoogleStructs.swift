//
//  GoogleStructs.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/29/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Entity {
    
    var name: String
    var salience: Float
    var type: String
    var wikipediaURL: String?
    
    init(fromJSON json: JSON) {
        //self.json = json
        self.name = json["name"].stringValue
        self.salience = json["salience"].floatValue
        self.type = json["type"].stringValue
        
        let metadata = json["metadata"].dictionaryValue
        if let wiki = metadata["wikipedia_url"]?.stringValue {
            self.wikipediaURL = wiki
        }
    }
}


struct Sentiment {
    
    var text: String?
    var magnitude: Float?
    var score: Float?
    var beginOffset: Int?
    var type: SentimentType
    
    enum SentimentType {
        case document
        case sentence
    }
    
    init(magnitude: Float?, score: Float?, type: SentimentType) {
        self.magnitude = magnitude
        self.score = score
        self.type = type
    }
    
    init(fromJSON json: JSON, type: SentimentType) {
        self.type = type
        
        let text = json["text"].dictionaryValue
        if let content = text["content"] {
            self.text = content.stringValue
        }
        if let offset = text["beginOffset"] {
            self.beginOffset = offset.int!
        }
        
        let sentimentInfo = json["sentiment"].dictionaryValue
        if let magnitude = sentimentInfo["magnitude"] {
            self.magnitude = magnitude.floatValue
        }
        if let score = sentimentInfo["score"] {
            self.score = score.floatValue
        }
    }
    
}
