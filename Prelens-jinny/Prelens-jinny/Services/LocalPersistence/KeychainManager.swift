//
//  KeychainManager.swift
//  Prelens-jinny
//
//  Created by vinova on 3/13/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import KeychainSwift

enum KeychainItem: String {
    case token          = "Token"
    case timeValid      = "TimeValid"
    case tenantName     = "TenantName"
    case tenantId       = "tenantId"
    case displayName    = "DisplayName"
    case avatarUrl      = "AvatarUrl"
    case loginId        = "LoginId"
    case password       = "Password"
    case userId         = "UserId"
    case isShowTerm     = "IsShowTerm"
}

class KeychainManager {
    static let shared: KeychainManager = {
        let instance = KeychainManager()
        
        return instance
    }()
    
    let keychain = KeychainSwift()
    
    func setToken(_ token: String) {
        keychain.set(token, forKey: KeychainItem.token.rawValue)
    }
    
    func getToken() -> String? {
        return keychain.get(KeychainItem.token.rawValue)
    }
    
    func setValidTime(_ expirationTime: Double) {
        let currentTimestamp    = NSDate().timeIntervalSince1970
        let timeValid           = currentTimestamp + expirationTime
        keychain.set(timeValid.description, forKey: KeychainItem.timeValid.rawValue)
    }
    
    func getValidTime() -> Double? {
        let valid                   = keychain.get(KeychainItem.timeValid.rawValue)
        guard let validTimestamp    = valid else { return nil }
        return Double(validTimestamp)
    }
    
//    func checkValid() -> Bool {
//        guard let validTime = getValidTime() else {
//            return false
//        }
//        let validTimeSecond     = validTime / 1000 //miliseconds to seconds
//        let currentTimestamp    = NSDate().timeIntervalSince1970
//        return validTimeSecond + bufferExpirationTime < currentTimestamp
//    }
    
    func deleteAllSavedData() {
        keychain.clear()
        
    }
    
    func deleteToken() {
        keychain.delete(KeychainItem.token.rawValue)
    }
    
    func saveTokenUser(login: PRUser?) {
        if let token = login?.token {
            KeychainManager.shared.setToken(token)
        }
    }
    
    //---
    func saveString(value: String, forkey key: KeychainItem) {
        keychain.set(value, forKey: key.rawValue)
    }
    
    func getString(key: KeychainItem) -> String? {
        return keychain.get(key.rawValue)
    }
    
}

