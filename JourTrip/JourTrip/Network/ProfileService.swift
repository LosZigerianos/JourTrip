//
//  ProfileService.swift
//  JourTrip
//
//  Created by Alexandre on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol ProfileService {
    func getProfile(by userID: String,
                    completion: @escaping (_ response: ProfileResponse?, _ error: Error?) -> Void)
    func deleteComment(with commentID: String,
                    completion: @escaping (_ response: ProfileResponse?, _ error: Error?) -> Void)
}
