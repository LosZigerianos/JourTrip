//
//  UserResponse.swift
//  JourTrip
//
//  Created by Alexandre on 27/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import ObjectMapper

final class UserLogin: Mappable {
    var success: Bool?
    var metadata: Metadata?
    var token: String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        metadata <- map["metadata"]
        token <- map["data"]
    }
}

final class Metadata: Mappable {
    var fullname: String?
    var following: [String]?
    var provider: String?
    var id: String?
    var email: String?
    var creationDate: String?
    var updatedAt: String?

    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        fullname <- map["fullname"]
        following <- map["following"]
        provider <- map["provider"]
        id <- map["_id"]
        email <- map["email"]
        creationDate <- map["creation_date"]
        updatedAt <- map["updated_at"]
    }
}

final class UserResponse: Mappable {
    var success: Bool?
    var result: UserModel?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        result <- map["result"]
    }
}

final class UserModel: Mappable {
    var email: String?
    var password: String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        password <- map["password"]
    }
}
