//
//  Address.swift
//  JourTrip
//
//  Created by Alexandre on 23/4/19.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Location: Object, Mappable {
    
    @objc dynamic var addressId: String?
    @objc dynamic var name: String?
    @objc dynamic var fullAddress: String?
    var photos = List<String>()
    var comments = List<Comment>()
    var tags = List<String>()
    @objc dynamic var rating: String?
    //    var long = RealmOptional<Double>()
    //    var lat = RealmOptional<Double>()

    // TODO: match with json data
    func mapping(map: Map) {
        addressId <- map["id"]
        name <- map["name"]
        fullAddress <- map["description"]
        photos <- map["photos"]
        comments <- map["comments"]
        tags <- map["tags"]
        rating <- map["rating"]
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "addressId"
    }
}
