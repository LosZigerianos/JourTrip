//
//  User.swift
//  JourTrip
//
//  Created by Alexandre on 23/4/19.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var userImage: String?
    @objc dynamic var userId: String?
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    convenience init(email: String, userId: String) {
        self.init()
        self.email = email
        self.userId = userId
    }
}
