//
//  ServiceProxy.swift
//  JourTrip
//
//  Created by Alexandre on 25/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RxSwift
import Simple_KeychainSwift

protocol LocationsServiceType {
    func getLocations(token: String,
                      completion: @escaping (_ response: LocationsResponse?, _ error: Error?) -> Void)
}

struct ServiceProxy: LoginServiceType, RegisterServiceType, LocationsServiceType {

    func register(with credentials: Credentials,
                  completion: @escaping (_ response: UserResponse?, _ error: Error?) -> Void) {
        let parameters: Parameters = ["email": credentials.email, "password": credentials.password]
        
        let url = ConstantNetworking.localUrl + ConstantNetworking.signup
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseObject  { (response: DataResponse<UserResponse>) in
            if response.result.isSuccess {
                let userResponse = response.result.value
                completion(userResponse, nil)
            }
        }
    }

	func register(with credentials: Credentials) -> Single<Void> {
		return Single.create { observer in
			self.login(with: credentials) { response, error in
				if let error = error {
					observer(.error(error))
				}

				if let _ = response {
					observer(.success(()))
				}
			}
			return Disposables.create()
		}
	}
    
    func login(with credentials: Credentials,
               completion: @escaping (_ response: UserLogin?, _ error: Error?) -> Void) {
        let parameters: Parameters = ["email": credentials.email, "password": credentials.password]
        
        let url = ConstantNetworking.localUrl + ConstantNetworking.login
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseObject  { (response: DataResponse<UserLogin>) in
            // todo: check error
            if response.result.isSuccess {
                guard let userLogin = response.result.value,
                    let metadata = userLogin.metadata,
                    let userID = metadata.id,
                    let token = userLogin.token else {
                        fatalError("no token provided")
                }
                DataManager.sharedInstance.save(value: token, key: "token")
                _ = DataManager.sharedInstance.saveSecure(value: userID, key: ConstantsDataManager.id)
                RealmManager.sharedInstance.save(user: userLogin)
                
                completion(userLogin, nil)
            }
        }
    }

    func login(with credentials: Credentials) -> Single<Void> {
        return Single.create { observer in
            self.login(with: credentials) { response, error in
                if let error = error {
                    observer(.error(error))
                }

                if let _ = response {
                    observer(.success(()))
                }
            }
            return Disposables.create()
        }
    }
    // TODO: Separate to locationService
    func getLocations(token: String,
                      completion: @escaping (_ response: LocationsResponse?, _ error: Error?) -> Void) {
        let url = ConstantNetworking.localUrl + ConstantNetworking.locations + "?name=Ayuntamiento&token=\(token)"
        
        AF.request(url).responseObject { (response: DataResponse<LocationsResponse>) in
            if let locationsResponse = response.result.value as LocationsResponse? {
                completion(locationsResponse, nil)
            }
            completion(nil, response.error as NSError?)
        }
    }
    
    func getNearLocations(token: String, latitude: Double, longitude: Double,
                          completion: @escaping (_ response: LocationsResponse?, _ error: Error?) -> Void) {
        
        let url = ConstantNetworking.localUrl
            + ConstantNetworking.locationsNear
            + "?latitude=\(latitude)&longitude=\(longitude)&token=\(token)&skip=3&limit=2"
        
        AF.request(url).responseObject { (response: DataResponse<LocationsResponse>) in
            if let locationsResponse = response.result.value as LocationsResponse? {
                completion(locationsResponse, nil)
            } else {
                completion(nil, response.error as NSError?)
            }
        }
    }
}
