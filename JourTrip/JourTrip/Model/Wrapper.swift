//
//  Wrapper.swift
//  JourTrip
//
//  Created by Alexandre on 25/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

import UIKit
import RealmSwift

class Wrapper: NSObject {
    func userToDBFrom(userModel: UserModel) -> UserRealm {
        let realmUser = UserRealm()
        
        realmUser.email = userModel.email ?? "fail"
        realmUser.id = userModel.id ?? "fail"
        realmUser.name = userModel.fullname ?? "fail"
        realmUser.userImage = "todo"
        
        return realmUser
    }
    //userSendFrom
    func userModelFrom(userRealm: UserRealm) -> UserModel {
        guard let userModel = UserModel(fullname: userRealm.name,
                                        following: [],
                                        provider: "",
                                        id: userRealm.id,
                                        email: userRealm.email,
                                        creationDate: "",
                                        updatedAt: "") else {
                                            fatalError("UserModel Error")
        }
        return userModel
    }
}

