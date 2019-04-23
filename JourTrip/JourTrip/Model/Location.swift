//
//  Address.swift
//  JourTrip
//
//  Created by Alexandre on 23/4/19.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic var addressId: String?
    @objc dynamic var name: String?
    @objc dynamic var fullAddress: String?
    var photos = List<String>()
    var comments = List<Comment>()
    var tags = List<String>()
//    var long = RealmOptional<Double>()
//    var lat = RealmOptional<Double>()
    
    override static func primaryKey() -> String? {
        return "addressId"
    }
}
