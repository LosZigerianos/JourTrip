//
//  SearchViewController.swift
//  JourTrip
//
//  Created by Alexandre on 20/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Kingfisher
import CoreLocation

final class SearchViewController: UIViewController {
    // MARK: - IBOutlet
	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			let nib = UINib(nibName: "NearCollectionViewCell", bundle: nil)
			collectionView.register(HeaderView.self,
									forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
									withReuseIdentifier: HeaderView.reuseIdentifier)
			collectionView.register(nib,
									forCellWithReuseIdentifier: NearCollectionViewCell.reuseIdentifier)
		}
	}
    
	// MARK: - Constants
	enum Constants {
		static let columns: CGFloat = 2
		static let spacing: CGFloat = 8
	}

    // MARK: - Dependencies
	var dataSource: SearchCollectionViewDataSource!
	var delegate: SearchCollectionViewDelegate!
	var getNearLocations: GetNearLocationsProtocol!
	var getCurrentLocation: GetCurrentLocationProtocol!

	// MARK: - Properties
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
		setupCollectionView()
		populateSearchData()
    }
}

// MARK: - Private Methods
private extension SearchViewController {
	func populateSearchData() {
		getCurrentLocation.invoke { [weak self] position in
			guard let self = self else { return }
			self.getNearLocations.invoke(with: position) { locations in
				self.dataSource.locations = locations
				self.collectionView.reloadData()
			}
		}
	}

	func setupCollectionView() {
		collectionView.delegate = delegate
		collectionView.dataSource = dataSource
		collectionViewLayout.sectionInset = UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
		collectionViewLayout.minimumLineSpacing = Constants.spacing
		collectionViewLayout.minimumInteritemSpacing = Constants.spacing
		collectionViewLayout.headerReferenceSize = .init(width: view.bounds.width, height: 150)
		collectionView.collectionViewLayout = collectionViewLayout
	}
}

extension SearchViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//		let text = textField.text ?? ""
//		if text.isEmpty {
//			isSearching = false
//			collectionView.reloadData()
//		}
//
//		if text.count > 2 {
//			isSearching = true
//			filteredLocations = locations.filter { location in
//				(location.name?.lowercased().contains(text.lowercased()))!
//			}
//		}
//		textField.resignFirstResponder()
		return false
	}
}
