//
//  SearchCollectionViewDelegate.swift
//  JourTrip
//
//  Created by Adrián Silva on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class SearchCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	// MARK: - Constants
	enum Constants {
		static let columns: CGFloat = 2
		static let spacing: CGFloat = 8
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let totalSpacing = (2 * Constants.spacing) + ((Constants.columns - 1) * Constants.spacing)

		let width = (collectionView.bounds.width - totalSpacing) / Constants.columns
		return CGSize(width: width, height: width)
	}
}
