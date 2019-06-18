//
//  LocationService.swift
//  JourTrip
//
//  Created by Adrián Silva on 31/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol LocationsServiceType {
	func getLocations(byName name: String,
					  completion: @escaping (_ response: LocationsResponse?, _ error: Error?) -> Void)
	func getNearLocations(latitude: Double,
						  longitude: Double,
						  completion: @escaping (_ response: LocationsResponse?, _ error: Error?) -> Void)
}
