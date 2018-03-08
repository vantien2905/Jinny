//
//  KeychainManager.swift
//  Prelens-jinny
//
//  Created by Lamp on 7/3/18.
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
    
    func checkValid() -> Bool {
        guard let validTime = getValidTime() else {
            return false
        }
        let validTimeSecond     = validTime / 1000 //miliseconds to seconds
        let currentTimestamp    = NSDate().timeIntervalSince1970
        return validTimeSecond + bufferExpirationTime < currentTimestamp
    }
}
