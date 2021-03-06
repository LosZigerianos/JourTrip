//
//  RealmManager.swift
//  JourTrip
//
//  Created by Alexandre on 25/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import RealmSwift
import Simple_KeychainSwift

class RealmManager: NSObject {
    //TODO: database migration when try! Realm() crash
    static let sharedInstance = RealmManager()
    fileprivate let wrapper = Wrapper()
    fileprivate let realm = try! Realm()
    
    func save(user: UserLogin) -> Void {
//        let userModel = user.metadata
//        let realmUser: UserRealm = wrapper.userToDB(from: userModel)
//        
//        try! realm.write { () -> Void in
//            realm.add(realmUser, update: true)
//        }
    }
    // TODO: userId
    func getUser(with userID: String?) -> Metadata {
        let userID = DataManager.sharedInstance.loadValue(key: ConstantsDataManager.id)
        
        let realmUser : Results<UserRealm> = {
            realm.objects(UserRealm.self).filter("id == %@", userID)
        }()
        
        return wrapper.userMetadata(from: realmUser.first!)
    }
}

