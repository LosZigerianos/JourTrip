//
//  GetCurrentLocation.swift
//  JourTrip
//
//  Created by Adrián Silva on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import CoreLocation

protocol GetCurrentLocationProtocol {
	func invoke(_ completion: @escaping (Position) -> ())
}

class GetCurrentLocation: NSObject, GetCurrentLocationProtocol, CLLocationManagerDelegate {
	var defaultLatitude = 41.6560593
	var defaultLongitude = -0.87734
	var locationManager: CLLocationManager = .init() {
		didSet {
			locationManager.delegate = self
			locationManager.requestWhenInUseAuthorization()
		}
	}

	func invoke(_ completion: @escaping (Position) -> ()) {
		let location = locationManager.location?.coordinate

		let position = Position(latitude: location?.latitude ?? defaultLatitude,
								longitude: location?.longitude ?? defaultLongitude)
		completion(position)
	}
}
