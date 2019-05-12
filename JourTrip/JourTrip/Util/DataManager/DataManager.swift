//
//  DataManager.swift
//  JourTrip
//
//  Created by Alexandre on 26/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Simple_KeychainSwift

class DataManager: NSObject {
    
    fileprivate var defaults: UserDefaults? = nil
    static let sharedInstance = DataManager()
    
    override init() {
        defaults = UserDefaults.standard
    }
    
    func save(value: Any, key: String) {
        self.defaults?.set(value, forKey: key)
        self.defaults?.synchronize()
    }
    
    func loadValue(key: String) -> Any {
        return self.defaults?.value(forKey: key) as Any
    }
    
    func removeValue(key: String) {
        self.defaults?.removeObject(forKey: key)
    }
    
    func saveSecure(value: String, key: String) -> Bool {
        return Keychain.set(value, forKey: key)
    }
    
    func loadSecureValue(key: String) -> String {
//        return Keychain.value(forKey: key) != nil ? Keychain.value(forKey: key)! : ""
        return ""
    }
    
    func removeSecureValue(key: String) -> Bool {
        return Keychain.removeValue(forKey: key)
    }
    
    func removeAllSecureValues() -> Bool {
        return Keychain.reset()
    }
}

