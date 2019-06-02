//
//  GetNearLocations.swift
//  JourTrip
//
//  Created by Adrián Silva on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

typealias Position = (latitude: Double, longitude: Double)

protocol GetNearLocationsProtocol {
	func invoke(with position: Position, completion: @escaping ([Location]) -> ())
}

struct GetNearLocations: GetNearLocationsProtocol {

	private let repository: LocationsServiceType

	init(repository: LocationsServiceType) {
		self.repository = repository
	}

	func invoke(with position: Position, completion: @escaping ([Location]) -> ()) {
		repository.getNearLocations(latitude: position.latitude, longitude: position.longitude) { response, error in
			guard let locations = response?.data else { return }
			completion(locations)
		}
	}
}
