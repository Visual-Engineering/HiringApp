//
//  Keychain.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 25/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation

struct Keychain {
    
    struct KeychainConfiguration {
        static let serviceName = "HiringApp"
        static let accessGroup: String? = nil
    }
    
    struct Constants {
        // MARK: TODO - Delete this constant and use the real user's username
        // that will be associated to the UUID saved into the Keychain
        static let userName = "userName"
    }
    
    static let shared = Keychain()
    
    var uuidIdentifier: String
    
    let token:  String
    
    private init() {
        uuidIdentifier = ""
        token = ""
    }
    
    mutating func getUUID() -> String? {
        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                              account: Constants.userName)
        
        guard let uuid = try? passwordItem.readPassword() else {
            return createUUID()
        }
        return uuid
    }
    
    mutating func createUUID() -> String? {
        let generatedUUID = UIDevice.current.identifierForVendor?.uuidString
        guard let _generatedUUID = generatedUUID else { return nil }
        
        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                account: Constants.userName,
                                                accessGroup: KeychainConfiguration.accessGroup)
        
        do {
            try passwordItem.savePassword(_generatedUUID)
        } catch {
            fatalError("Error saving password")
        }
        
        uuidIdentifier = _generatedUUID
        
        return _generatedUUID
    }
}
