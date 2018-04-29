//: Playground - noun: a place where people can play

import Foundation
import SwiftyJSON


class GoogleLangugageParser {
    
    let session = URLSession.shared
    let googleAPIKey = "85f480c93c5e74506fd53a40de721efe96ee8de2"
    var googleURL: URL {
        return URL(string: "https://language.googleapis.com/v1/documents:analyzeSentiment?key=\(googleAPIKey)")!
    }
    
    private func createRequest(with text: String, handler: @escaping (String) -> Void) {
        // Create our request URL
        
        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        let jsonRequest = [
            "requests": [
                ["encodingType": "UTF8",
                 "document": [
                    "type": "PLAIN_TEXT",
                    "content": text
                    ]
                ]
            ]
            
        ]
        
        let jsonObject = JSON(jsonRequest)
        
        // Serialize the JSON
        guard let data = try? jsonObject.rawData() else {
            return
        }
        
        request.httpBody = data
        
        DispatchQueue.main.async {
            self.session.dataTask(with: request, completionHandler: { (data, response, error) in
                //
                guard error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                if let data = data {
                    dump(data)
                }
            }).resume()
        }
        // Run the request on a background thread
        
    }
    
    
}
