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
    func userToDB(from userModel: Metadata) -> UserRealm {
        let realmUser = UserRealm()
        
        realmUser.email = userModel.email ?? ""
        realmUser.userId = userModel.id ?? ""
        realmUser.name = userModel.fullname ?? ""
        realmUser.userImage = "todo"
        
        return realmUser
    }
    
    func userMetadata(from userRealm: UserRealm) -> Metadata {
        guard let userModel = Metadata(fullname: userRealm.name, following: [], provider: "", id: userRealm.userId!, email: userRealm.email, creationDate: "", updatedAt: "") else {
            fatalError("userModel error from userRealm")
        }
        return userModel
    }
}

