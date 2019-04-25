//
//  ServiceError.swift
//  JourTrip
//
//  Created by Alexandre on 25/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case notFound
    case tokenExpired
    case invalidRequest
    case unprocessableEntity(NSDictionary?)
    case notAllowed
    case notLogged(String?)
    case unprocessableError(String?)
    case badRequest
    case unknownError(Error?)
    case noConnection
}
