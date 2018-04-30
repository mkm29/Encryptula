//
//  GoogleLanguage.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/29/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Endpoint {
    case entities
    case sentiment
    case entitySentiment
    case syntax
//    case annotate
//    case classify
}

class GoogleLanguage {
    
    let session = URLSession.shared
    let googleAPIKey = "AIzaSyAt9G6WCrs8gzTGLKXt_nfMOZx4kFS0Um0"
    
    private func createRequest(endpoint: Endpoint, forText text: String) -> URLRequest? {
        var urlString = "https://language.googleapis.com/v1/documents:"
        switch endpoint {
        case .sentiment:
            urlString += "analyzeSentiment?key=\(googleAPIKey)"
        case .entities:
            urlString += "analyzeEntities?key=\(googleAPIKey)"
        case .entitySentiment:
            urlString += "analyzeEntitySentiment?key=\(googleAPIKey)"
        case .syntax:
            urlString += "analyzeSyntax?key=\(googleAPIKey)"
//        case .annotate:
//            urlString += "annotateText?key=\(googleAPIKey)"
//        case .classify:
//            urlString += "classifyText?key=\(googleAPIKey)"
        }
        if let googleURL = URL(string: urlString) {
            // Create our request URL
            var request = URLRequest(url: googleURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
            
            // Build our API request
            var jsonDictionary: [String : Any]!
            
            
            jsonDictionary = [
                "encodingType": "UTF8",
                "document": [
                    "type": "PLAIN_TEXT",
                    "content": text
                ]
            ]
            
            let json = JSON(jsonDictionary)
            
            guard let data = try? json.rawData() else {
                print("There was an error converting the JSON to raw data")
                return nil
            }
            request.httpBody = data
            return request
        } else {
            return nil
        }
        
    }
    
    func analyzeSentiment(text: String, completion: @escaping (_ error: Error?, _ sentiments: [Sentiment]?) -> Void) {
        if let request = createRequest(endpoint: .sentiment, forText: text) {
            DispatchQueue.main.async {
                self.session.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard error == nil else {
                        completion(error, nil)
                        return
                    }
                    if let data = data {
                        // try to convert to JSON
                        if let json = self.toJSON(result: data) {
                            var sentiments: [Sentiment] = [Sentiment]()
                            // first add the document sentiment
                            let documentSent = json["documentSentiment"].dictionaryValue
                            let documentMagnitude = documentSent["magnitude"]?.floatValue
                            let documentScore = documentSent["score"]?.floatValue
                            let ds = Sentiment.init(magnitude: documentMagnitude, score: documentScore, type: .document)
                            sentiments.append(ds)
                            
                            let sentimentsJSON = json["sentences"].arrayValue
                            for sentiment in sentimentsJSON {
                                sentiments.append(Sentiment.init(fromJSON: sentiment, type: .sentence))
                            }
                            
                            completion(nil, sentiments)
                        } else {
                            let error = NSError(domain: "Unable to convert data to JSON", code: 2, userInfo: nil)
                            completion(error, nil)
                        }
                    }
                }).resume()
            }
        }
        else {
            let error = NSError(domain: "Unable to create request", code: 1, userInfo: nil)
            completion(error, nil)
        }
        
    }
    
    private func toJSON(result: Data) -> JSON? {
        if let json = try? JSON(data: result) {
            return json
        } else {
            return nil
        }
    }
    
    func analyzeEntities(text: String, completion: @escaping (_ error: Error?,_ entities: [Entity]?) -> Void) {
        if let request = createRequest(endpoint: .entities, forText: text) {
            DispatchQueue.main.async {
                self.session.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard error == nil else {
                        completion(error, nil)
                        return
                    }
                    if let data = data, let json = self.toJSON(result: data) {
                        var entities: [Entity] = [Entity]()
                        let entitiesJSON = json["entities"].arrayValue
                        for entity in entitiesJSON {
                            entities.append(Entity.init(fromJSON: entity))
                        }
                        
                        completion(nil, entities)
                    } else {
                        let error = NSError(domain: "Unable to convert data to JSON", code: 2, userInfo: nil)
                        completion(error, nil)
                    }
                }).resume()
            }
        } else {
            let error = NSError(domain: "Unable to create URL request", code: 1, userInfo: nil)
            completion(error, nil)
        }
    }
    
    func analyzeEntitySentiment(text: String, completion: @escaping (_ error:Error?, _ sentiment: Any?) -> Void) {
        if let request = createRequest(endpoint: .entitySentiment, forText: text) {
            DispatchQueue.main.async {
                self.session.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard error == nil else {
                        completion(error, nil)
                        return
                    }
                    if let data = data, let json = self.toJSON(result: data) {
                        completion(nil, json)
                    } else {
                        let error = NSError(domain: "Unable to convert data to JSON", code: 2, userInfo: nil)
                        completion(error, nil)
                    }
                }).resume()
            }
        }  else {
            let error = NSError(domain: "Unable to create URL request", code: 1, userInfo: nil)
            completion(error, nil)
        }
    }
    
}
