//
//  GoogleStructs.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/29/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation

struct Entity {
    
    var name: String
    var salience: Float
    var type: String
    var wikipediaURL: String?
    
    init(fromJson json: [String:Any]) {
        self.name = json["name"] as! String
        if let salienceString = json["salience"] as? String {
            self.salience = Float(salienceString)!
        } else {
            self.salience = 0.0
        }
        self.type = json["type"] as! String
        if let metadata = json["metadata"] as? [String:Any], let wiki = metadata["wikipedia_url"] as? String {
            self.wikipediaURL = wiki
        }
    }
}


struct Sentiment {
    
    var text: String = ""
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
    
    init(fromJSON json: [String: Any], type: SentimentType) {
        self.type = type
        
        if let text = json["text"] as? [String: Any] {
            if let content = text["content"] as? String {
                self.text = content
            }
            if let offset = text["beginOffset"] as? String {
                self.beginOffset = Int(offset)!
            }
        }
        
        if let sentiment = json["sentiment"] as? [String:Any] {
            if let magnitude = sentiment["magnitude"] as? String {
                self.magnitude = Float(magnitude)!
            }
            if let score = sentiment["score"] as? String {
                self.score = Float(score)!
            }
        }
    }
    
}
