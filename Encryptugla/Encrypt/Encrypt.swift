//
//  Crypto.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/23/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation
import Security

class Encrypt {
    
    private var certificate: SecCertificate?
    private var publicKey: SecKey?
    private let algorithm: SecKeyAlgorithm = SecKeyAlgorithm.rsaEncryptionOAEPSHA512AESGCM
    
    var setupStatus: Bool = false
    
    enum EncryptionError: Error {
        case algorithmNotSupported
        case textLengthTooSmall
    }
    
    init() {
        if let certificate = getCertificate() {
            if let publicKey = getPublicKeyFromCertificate(certificate: certificate) {
                self.publicKey = publicKey
                setupStatus = true
                // test algorith to encrypt/decrypt
                //testEncryption()
            }
        }
    }
    
    func testEncryption() {
        let textToEncrypt = "Mitchell Murphy"
        print("Encrypt this text: ", textToEncrypt)
        // 1. get cipher text
        do {
            if let cipherText = try encrypt(plainText: textToEncrypt) {
                print("encrypted text! cipher: ", cipherText)
                // 2. now lets decrypt this cipher!
                do {
                    if let plainText = try decrypt(cipherText: cipherText) {
                        print("decrypted text! plainText: ", plainText)
                    }
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
  
        
    }
    
    private func getCertificate() -> SecCertificate? {
        guard let url = Bundle.main.url(forResource: "certificate", withExtension: "der"),
            let data = NSData(contentsOf: url),
            let certificate = SecCertificateCreateWithData(kCFAllocatorDefault, data) else {
            print("Could not read certificate")
            return nil
        }
        return certificate
    }
    
    private func getPublicKeyFromCertificate(certificate: SecCertificate) -> SecKey? {
        // 1
        //guard let certRef = readCertificate() else { return nil }
        // 2
        var secTrust: SecTrust?
        let secTrustStatus = SecTrustCreateWithCertificates(certificate, nil, &secTrust)
        if secTrustStatus != errSecSuccess { return nil }
        // 3
        var resultType: SecTrustResultType = SecTrustResultType(rawValue: UInt32(0))! // ignore results.
        let evaluateStatus = SecTrustEvaluate(secTrust!, &resultType)
        if evaluateStatus != errSecSuccess { return nil }
        // 4
        let publicKeyRef = SecTrustCopyPublicKey(secTrust!)
        return publicKeyRef
    }
    
    // Input: a string you wish to encrypt using the loaded public key
    // Output: a base 64 encoded cipher text
    func encrypt(plainText: String) throws -> String? {
        if let publicKey = self.publicKey {
            let textData = NSData(data: plainText.data(using: .utf8)!)
            var error: Unmanaged<CFError>?
            guard let cipherText = SecKeyCreateEncryptedData(publicKey, self.algorithm, textData as CFData,  &error) as Data? else {
                throw error!.takeRetainedValue() as Error
            }
            return cipherText.base64EncodedString()
        }
        return nil
    }
    
    // Input: a base 64 encoded cipher text
    // Output: plain text, decrypted string
    func decrypt(cipherText: String) throws -> String? {
        if let publicKey = self.publicKey {
            let cipherTextData = NSData(data: cipherText.data(using: .utf8)!)
            var error: Unmanaged<CFError>?
            guard let plainText = SecKeyCreateDecryptedData(publicKey, self.algorithm, cipherTextData as CFData, &error) as Data? else {
                throw error!.takeRetainedValue() as Error
            }
            return plainText.base64EncodedString()
        }
        return nil
    }
 
}
