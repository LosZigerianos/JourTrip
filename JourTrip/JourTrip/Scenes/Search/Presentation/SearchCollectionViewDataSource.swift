//
//  SearchCollectionViewDataSource.swift
//  JourTrip
//
//  Created by Adrián Silva on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class SearchCollectionViewDataSource: NSObject, UICollectionViewDataSource {
	var locations = [Location]()
	var filteredLocations = [Location]()
	var isSearching = false

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if isSearching {
			return filteredLocations.count
		}
		return locations.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		var nearLocation = locations[indexPath.row]

		if isSearching {
			nearLocation = filteredLocations[indexPath.row]
		}

		let nearCell = collectionView.dequeueReusableCell(withReuseIdentifier: NearCollectionViewCell.reuseIdentifier, for: indexPath) as! NearCollectionViewCell

		if let photos = nearLocation.photos,
			let photo = photos.first,
			let url = URL(string: photo) {
			nearCell.locationImageView.kf.setImage(with: url)
			nearCell.cityLabel.text = nearLocation.city
			nearCell.nameLabel.text = nearLocation.name

			return nearCell
		}

		return NearCollectionViewCell()
	}
}
