//
//  Crypto.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/23/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation
import CoreFoundation
import Security
import SimpleKeychain

class Encryptula {
    func test() {
        // generating key pair
        let keyPair: (publicKey: SecKey?, privateKey: SecKey?) = generateKeyPair()
        // calculate blocksize
        let blockSize: Int = SecKeyGetBlockSize(keyPair.publicKey!)
        
        // preparing for encryption
        let plainText: String = "sample text to be encrypted and decrypted"
        let plainTextData: [UInt8] = [UInt8](plainText.utf8)
        let plainTextDataLength: Int = plainText.count //plainText.characters.count
        var encryptedData: [UInt8] = [UInt8](repeating: 0, count: Int(blockSize))
        var encryptedDataLength: Int = blockSize
        
        // encrypting
        let encryptOsStatus: OSStatus = SecKeyEncrypt(keyPair.publicKey!, SecPadding.PKCS1, plainTextData, plainTextDataLength, &encryptedData, &encryptedDataLength)
        if encryptOsStatus != noErr {
            print("Encryption Error")
            return;
        }
        
        // preparing for decryption
        var decryptedData: [UInt8] = [UInt8](repeating: 0, count: Int(blockSize))
        var decryptedDataLength: Int = blockSize
        
        // decrypting
        let decryptOsStatus: OSStatus = SecKeyDecrypt(keyPair.privateKey!, SecPadding.PKCS1, encryptedData, encryptedDataLength, &decryptedData, &decryptedDataLength)
        if decryptOsStatus != noErr {
            print("Decryption Error")
            return;
        }
        
        // checking
        let text: NSString = NSString(bytes: &decryptedData, length: decryptedDataLength, encoding: String.Encoding.utf8.rawValue)!
        if text.compare(plainText) == ComparisonResult.orderedSame {
            print("success")
        } else {
            print("failure")
        }
    }
    
    private func storePrivateKey(key: String) -> Void {
        // 
    }
    
    private func getPrivateKey() -> SecKey? {
        
        
        
        return nil
    }
    
    func encrypt(textToEncrypt: String) -> String? {
        
        
        return nil
    }
    
    func decrypt(textToDecrypt: String) -> String {
        
        
        return textToDecrypt
    }
    
    func generateKeyPair () -> (publicKey: SecKey?, privateKey: SecKey?) {
        let parameters: [String: AnyObject] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String: 2048 as AnyObject
        ]
        var publicKey: SecKey?
        var privateKey: SecKey?
        let osStatus: OSStatus = SecKeyGeneratePair(parameters as CFDictionary, &publicKey, &privateKey)
        switch osStatus {
        case noErr:
            return (publicKey, privateKey)
        default:
            // TODO: error handling
            return (nil, nil)
        }
    }
}
