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
 
}
