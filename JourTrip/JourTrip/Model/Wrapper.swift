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
    func userToDBFrom(userModel: Metadata) -> UserRealm {
        let realmUser = UserRealm()
        
        realmUser.email = userModel.email ?? "test"
        realmUser.id = userModel.id ?? "test"
        realmUser.name = userModel.fullname ?? "test"
        realmUser.userImage = "todo"
        
        return realmUser
    }
    
//    func userModelFrom(userRealm: UserRealm) -> Metadata {
////        guard let userModel = Metadata(fullname: userRealm.name,
////                                  following: [],
////                                  provider: "",
////                                  id: userRealm.id,
////                                  email: userRealm.email,
////                                  creationDate: "",
////                                  updatedAt: "") else {
////                                    fatalError("UserModel Error")
////        }
//        return userModel(9)
//    }
}
