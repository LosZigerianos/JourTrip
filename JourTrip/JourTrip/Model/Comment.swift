//
//  Comment.swift
//  JourTrip
//
//  Created by Alexandre on 23/4/19.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RealmSwift

class Comment: Object {
    var commentId: String = ""
    var message: String = ""
    
    override static func primaryKey() -> String? {
        return "userId"
    }
}
