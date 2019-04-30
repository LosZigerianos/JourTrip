//
//  ConstantNetworking.swift
//  JourTrip
//
//  Created by Alexandre on 25/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

struct ConstantNetworking {
    static let localUrl = "http://localhost:3000/apiv1/"
    static let signup = "users/signup"
    static let login = "users/login"
    static let locations = "/locations?name=Ayuntamiento&token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNWNjNzVkNGY5OTNhZjJiNzdjZjQxMzMzIiwiaWF0IjoxNTU2NTY5NDM3LCJleHAiOjE1NTY2NTU4Mzd9.Lt_ZDC_EZJFWkFB998idkT2FHDeCk8wMnhHRFMvifyU"
    static let addresses = "/addresses"
    static let allMessages = "/all/messages"
    static let emailAlreadyRegisteredMessage = "Email already registered"
}
