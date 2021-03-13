//
//  Keychain.swift
//  Net01
//
//  Created by Alexey Golovin on 13.03.2021.
//

import Foundation

final class Keychain {
    func keychainQuery(service: String, account: String? = nil) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlocked
        query[kSecAttrService as String] = service as AnyObject
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject
        }
        
        return query
    }
    
    func readPassword(service: String, account: String?) -> String? {
        var query = keychainQuery(service: service, account: account)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        
        var queryResult: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer(&queryResult))
        
        if status != noErr {
            return nil
        }
        
        guard let item = queryResult as? [String : AnyObject],
            let passwordData = item[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: .utf8) else {
                return nil
        }
        return password
    }
    
    func savePassword(password: String, service: String, account: String?) -> Bool {
        let passwordData = password.data(using: .utf8)
        
        if readPassword(service: service, account: account) != nil {
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = passwordData as AnyObject
            
            let query = keychainQuery(service: service, account: account)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            return status == noErr
        }
        
        var item = keychainQuery(service: service, account: account)
        item[kSecValueData as String] = passwordData as AnyObject
        let status = SecItemAdd(item as CFDictionary, nil)
        return status == noErr
    }
    
    func readAllItems(service: String) -> [String : String]? {
        var query = keychainQuery(service: service)
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        
        var queryResult: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer(&queryResult))
        
        if status != noErr {
            return nil
        }
        
        guard let items = queryResult as? [[String : AnyObject]] else {
            return nil
        }
        var passwordItems = [String : String]()
        
        for (index, item) in items.enumerated() {
            guard let passwordData = item[kSecValueData as String] as? Data,
                let password = String(data: passwordData, encoding: .utf8) else {
                    continue
            }
            
            if let account = item[kSecAttrAccount as String] as? String {
                passwordItems[account] = password
                continue
            }
            
            let account = "empty account \(index)"
            passwordItems[account] = password
        }
        return passwordItems
    }
    func deletePassword(service: String, account: String?) -> Bool {
        let item = keychainQuery(service: service, account: account)
        let status = SecItemDelete(item as CFDictionary)
        return status == noErr
    }
}
