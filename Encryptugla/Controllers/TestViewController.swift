//
//  TestViewController.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/30/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import UIKit
import Security

class TestViewController: UIViewController {

    let coordinator = Coordinator.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let udid = UIDevice.current.identifierForVendor!.uuidString
        
        print("-----------------------------")
        let plainText = "Mitchell Murphy"
        guard let cipherText = coordinator.encrypt.encrypt(text: plainText) else {
            print("Unable to encrypt text.")
            return
        }
        print("Successfully encrypted text: \(cipherText)")
        
        // now lets decrypt
        guard let decryptedText = coordinator.encrypt.decrypt(cipherText: cipherText) else {
            print("Unablel to decrypt text :(")
            return
        }
        print("Successfully decrypted text: \(decryptedText)")
    }
    
//    func encryptionTest()
//    {
//        let clearTextData = "some clear text to encrypt".data(using:String.Encoding.utf8)!
//        let dictionary = Encrypt.encryptData(clearTextData, withPassword: "123456")
//        let decrypted = Encrypt.decryp(fromDictionary: dictionary, withPassword: "123456")
//        let decryptedString = String(data: decrypted, encoding: String.Encoding.utf8)
//        print("decrypted cleartext result - ", decryptedString ?? "Error: Could not convert data to string")
//    }
    
    

}
