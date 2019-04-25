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
    static let signUp = "users/signin"
    static let login = "users/login"
    static let locations = "/locations"
    static let addresses = "/addresses"
    static let allMessages = "/all/messages"
    static let emailAlreadyRegisteredMessage = "Email already registered"
}
