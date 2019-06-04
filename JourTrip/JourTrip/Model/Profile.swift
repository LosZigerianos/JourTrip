//
//  Profile.swift
//  JourTrip
//
//  Created by Alexandre on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import ObjectMapper

final class ProfileResponse: Mappable {
    var success: Bool?
    var data: Profile?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
    }
}

final class Profile: Mappable {
    var fullname: String?
    var following, followers: Int?
    var comments: [Comment]?
    var photo: String?
    var provider, id, email, creationDate: String?
    var updatedAt, username: String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        fullname <- map["fullname"]
        following <- map["following"]
        followers <- map["followers"]
        comments <- map["comments"]
        photo <- map["photo"]
        provider <- map["provider"]
        id <- map["id"]
        email <- map["email"]
        creationDate <- map["creationDate"]
        updatedAt <- map["updatedAt"]
        username <- map["username"]
    }
}

final class Comment: Mappable {
    var id, user: String?
    var location: Location?
    var commentDescription, creationDate: String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        user <- map["user"]
        location <- map["location"]
        commentDescription <- map["commentDescription"]
        creationDate <- map["creationDate"]
    }
}
