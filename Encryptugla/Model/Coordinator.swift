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
    
    // unique identifier for the current device. Used to create AES key
    var users: [User] = [User]()
    // need a mapping between firebase User and User (mine)
    var currentUser: User? = nil
    var firebaseUser: FirebaseAuth.User?
    let encrypt: Encrypt = Encrypt()
    let firebase: FirebaseClient = FirebaseClient.shared
    
    enum ReadJSONError: Error {
        case pathDoesNotExist
        case unableToConvertToJSON
    }
    
    func getUDID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }


    // the following function is redundant
//    func getUsers() {
//        firebase.getAllUsers { (error, users) in
//            guard error == nil else {
//                print(error?.localizedDescription as Any)
//                return
//            }
//            if let users = users {
//                print("Got \(users.count) users")
//                self.users = users
//            }
//        }
//    }
    
    func readQuestionsJSON(jsonFilePrefix: String = "questions") throws -> [Question]? {
        var questions: [Question] = [Question]()
        if let path = Bundle.main.path(forResource: jsonFilePrefix, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let jsonQuestions = jsonResult["questions"] as? [[String:Any]] {
                    // do stuff
                    // now get each question
                    for question in jsonQuestions {
                        questions.append(Question.init(fromJson: question))
                    }
                } else {
                    print("Unable to convert to dictionary")
                    throw ReadJSONError.unableToConvertToJSON
                    
                }
            } catch let error {
                // handle error
                throw error
                
            }
        } else {
            throw ReadJSONError.pathDoesNotExist
        }
        return questions
    }
}
