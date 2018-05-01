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

enum SecKeyType {
    case publicKey
    case privateKey
}

class Encrypt {

    public var uid: String?
    //private let tagPrefix = "com.smigula.encryptula.keys"
    
    private var tagPrefix: String {
        get {
            return Bundle.main.bundleIdentifier! + ".keys"
        }
    }
    
    private var publicKey: SecKey?
    private var privateKey: SecKey?
    
    func ccSha256(data: Data) -> String {
        var digest: Data = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        
        _ = digest.withUnsafeMutableBytes { (digestBytes) in
            data.withUnsafeBytes { (stringBytes) in
                CC_SHA256(stringBytes, CC_LONG(data.count), digestBytes)
            }
        }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    private func generateKeyPair () -> (publicKey: SecKey?, privateKey: SecKey?) {
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
            print(osStatus)
            return (nil, nil)
        }
    }
    
    private func storeKey(key: SecKey, withType type: SecKeyType) {
        var tag: String!
        switch type {
        case .publicKey:
            tag = "com.smigula.keys.publicKey"
        case .privateKey:
            tag = "com.smigula.keys.privateKey"
        }
        
        let addQuery: [String: Any] = [kSecClass as String: kSecClass,
                                       kSecAttrApplicationTag as String: tag.data(using: .utf8)!,
                                       kSecValueRef as String: key]
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            // throw error
            print("there was an error storing the public key: ", status.description)
            return
        }
    }
    
    private func getKey(type: SecKeyType) -> SecKey? {
        var tag = self.tagPrefix
        
        switch type {
        case .publicKey:
            tag = tag + ".private"
        case .privateKey:
            tag = tag + ".pubic"
        }
        
        let getQuery: [String: Any] = [kSecClass as String: kSecClassKey,
                                       kSecAttrApplicationTag as String: tag,
                                       kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                                       kSecReturnRef as String: true]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(getQuery as CFDictionary, &item)
        guard status == errSecSuccess else {
            // throw error
            print("there was an error getting the key: ", status.description)
            return nil
        }
        let key = item as! SecKey
        return key
    }
    
    private func generateKeys() {
        let keyPair = generateKeyPair()
        
        if let publicKey = keyPair.publicKey {
            self.publicKey = publicKey
            storeKey(key: publicKey, withType: .publicKey)
        }
        if let privateKey = keyPair.privateKey {
            self.privateKey = privateKey
            storeKey(key: privateKey, withType: .privateKey)
        }
    }
 
    
    func encrypt(textToEncrypt: String) -> String? {
        
        
        return nil
    }
    
    func decrypt(textToDecrypt: String) -> String {
        
        
        return textToDecrypt
    }
    
//    func test() {
//        // generating key pair
//        let keyPair: (publicKey: SecKey?, privateKey: SecKey?) = generateKeyPair()
//        // calculate blocksize
//        let blockSize: Int = SecKeyGetBlockSize(keyPair.publicKey!)
//
//        // preparing for encryption
//        let plainText: String = "sample text to be encrypted and decrypted"
//        let plainTextData: [UInt8] = [UInt8](plainText.utf8)
//        let plainTextDataLength: Int = plainText.count //plainText.characters.count
//        var encryptedData: [UInt8] = [UInt8](repeating: 0, count: Int(blockSize))
//        var encryptedDataLength: Int = blockSize
//
//        // encrypting
//        let encryptOsStatus: OSStatus = SecKeyEncrypt(keyPair.publicKey!, SecPadding.PKCS1, plainTextData, plainTextDataLength, &encryptedData, &encryptedDataLength)
//        if encryptOsStatus != noErr {
//            print("Encryption Error")
//            return;
//        }
//
//        // preparing for decryption
//        var decryptedData: [UInt8] = [UInt8](repeating: 0, count: Int(blockSize))
//        var decryptedDataLength: Int = blockSize
//
//        // decrypting
//        let decryptOsStatus: OSStatus = SecKeyDecrypt(keyPair.privateKey!, SecPadding.PKCS1, encryptedData, encryptedDataLength, &decryptedData, &decryptedDataLength)
//        if decryptOsStatus != noErr {
//            print("Decryption Error")
//            return;
//        }
//
//        // checking
//        let text: NSString = NSString(bytes: &decryptedData, length: decryptedDataLength, encoding: String.Encoding.utf8.rawValue)!
//        if text.compare(plainText) == ComparisonResult.orderedSame {
//            print("success")
//        } else {
//            print("failure")
//        }
//    }
}
