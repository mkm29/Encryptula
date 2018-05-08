//
//  Crypto.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/23/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation
import SwiftyRSA

class Encrypt {
    
    var publicKey: PublicKey? = nil
    var privateKey: PrivateKey? = nil
    
    
    init() {
        // get the public and private keys
        do {
            self.publicKey = try PublicKey(pemNamed: "public")
            print("got public key!")
        } catch {
            print(error)
        }
        do {
            self.privateKey = try PrivateKey(pemNamed: "private")
            print("got private key!")
        } catch {
            print(error as Any)
        }
    }
    
    
    func encrypt(text: String) -> String? {
        guard let publicKey = self.publicKey else {
            print("No public key!")
            return nil
        }
        if let clear = try? ClearMessage(string: text, using: .utf8), let encrypted = try? clear.encrypted(with: publicKey, padding: .PKCS1) {
            //let data = encrypted.data
            let base64String = encrypted.base64String
            return base64String
        }
        return nil
    }
    
    func decrypt(cipherText: String) -> String? {
        guard let privateKey = self.privateKey else {
            print("No private key!")
            return nil
        }
        if let encrypted = try? EncryptedMessage(base64Encoded: cipherText), let clear = try? encrypted.decrypted(with: privateKey, padding: .PKCS1) {
            // Then you can use:
            //let data = clear.data
            //let base64String = clear.base64String
            if let string = try? clear.string(encoding: .utf8) {
                return string
            }
        }
        
        
        return nil
    }
 
}
