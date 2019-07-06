//
//  ProfileService.swift
//  JourTrip
//
//  Created by Alexandre on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol ProfileService {
    func getFollowers(completion: @escaping (_ response: ProfilesResponse?, _ error: Error?) -> Void)
    func getProfile(completion: @escaping (_ response: ProfileResponse?, _ error: Error?) -> Void)
    func deleteComment(with commentID: String,
					   completion: @escaping (_ response: ProfileResponse?, _ error: Error?) -> Void)
}


