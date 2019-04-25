//
//  User.swift
//  JourTrip
//
//  Created by Alexandre on 23/4/19.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class User: Object, Mappable {

    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var userImage: String?
    @objc dynamic var userId: String?
    
    // TODO: match with json data
    func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        userImage <- map["image"]
        userId <- map["id"]
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        return "userId"
    }

}
