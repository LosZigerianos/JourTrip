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
    var success: String?
    var metadata: Metadata?
    var data: String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
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
