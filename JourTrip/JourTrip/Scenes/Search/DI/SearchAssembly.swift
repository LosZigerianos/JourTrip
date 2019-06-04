//
//  SearchAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

class SearchAssembly {

	private let repository: LocationsServiceType

	init(repository: LocationsServiceType) {
		self.repository = repository
	}

	func viewController() -> SearchViewController {
		let viewController = SearchViewController()
		viewController.dataSource = dataSource()
		viewController.delegate = delegate()
		viewController.getNearLocations = getNearLocations()
		viewController.getCurrentLocation = getCurrentLocation()
		return viewController
	}

	func dataSource() -> SearchCollectionViewDataSource {
		return SearchCollectionViewDataSource()
	}

	func delegate() -> SearchCollectionViewDelegate {
		return SearchCollectionViewDelegate()
	}

	func getNearLocations() -> GetNearLocationsProtocol {
		return GetNearLocations(repository: repository)
	}

	func getCurrentLocation() -> GetCurrentLocationProtocol {
		return GetCurrentLocation()
	}
}
