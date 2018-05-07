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
