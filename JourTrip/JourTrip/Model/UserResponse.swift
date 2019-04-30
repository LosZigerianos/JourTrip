//
//  UserResponse.swift
//  JourTrip
//
//  Created by Alexandre on 27/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import ObjectMapper

class UserLogin: Mappable {
    var success : String?
    var token : String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        token <- map["token"]
    }
}

class UserResponse: Mappable {
    var success: Bool?
    var result: UserTest?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        result <- map["result"]
    }
}

class UserTest: Mappable {
    var email: String?
    var password: String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        password <- map["password"]
    }
}
