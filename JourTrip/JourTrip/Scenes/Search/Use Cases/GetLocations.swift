//
//  GetNearLocations.swift
//  JourTrip
//
//  Created by Adrián Silva on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

typealias Position = (latitude: Double, longitude: Double)

protocol GetLocationsProtocol {
	func invoke(with position: Position, completion: @escaping ([Location]) -> ())
	func invoke(with name: String, completion: @escaping ([Location]) -> ())
}

struct GetLocations: GetLocationsProtocol {

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

	func invoke(with name: String, completion: @escaping ([Location]) -> ()) {
		repository.getLocations(byName: name) { response, error in
			guard let locations = response?.data else { return }
			completion(locations)
		}
	}
}
