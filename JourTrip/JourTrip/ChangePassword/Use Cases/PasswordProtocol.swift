//
//  PasswordProtocol.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol GetPasswordProtocol {
    func updatePassword(with newPassword: String, insteadOf oldPassword:String, completion: @escaping (UserSignUp) -> ())
}

struct UpdatePassword: GetPasswordProtocol{
    
    private let repository: PasswordService
    
    init(repository: PasswordService) {
        self.repository = repository
    }
    
    func updatePassword(with newPassword: String,
                        insteadOf oldPassword: String,
                        completion: @escaping (UserSignUp) -> ()) {
        repository.updatePassword(newPassword: newPassword, oldPassword: oldPassword) { (response, error) in
                        guard let updatePasswordResponse = response else { return }
                        completion(updatePasswordResponse)
        }
//        repository.updatePassword(with: newPassword, insteadOf: oldPassword) { (response, error) in
//            guard let updatePasswordResponse = response else { return }
//            completion(updatePasswordResponse)
//        }
    }
    
//
//    func deleteComment(with commentID: String, completion: @escaping (ProfileResponse) -> ()) {
//        repository.deleteComment(with: commentID) { (response, error) in
//            guard let profile = response else { return }
//            completion(profile)
//        }
//    }
    
    
}

