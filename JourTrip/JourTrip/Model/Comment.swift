//
//  Comment.swift
//  JourTrip
//
//  Created by Alexandre on 23/4/19.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Comment: Object, Mappable {
    
    var commentId: String = ""
    var message: String = ""
    
    // TODO: match with json data
    func mapping(map: Map) {
        commentId <- map["id"]
        message <- map["message"]
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        return "userId"
    }
}
