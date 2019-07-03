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
			collectionView.register(nib,
									forCellWithReuseIdentifier: NearCollectionViewCell.reuseIdentifier)
		}
	}
	@IBOutlet weak var headerView: HeaderView!

	// MARK: - Constants
	enum Constants {
		static let columns: CGFloat = 2
		static let spacing: CGFloat = 8
	}

    // MARK: - Dependencies
	var dataSource: SearchCollectionViewDataSource!
	var delegate: SearchCollectionViewDelegate!
	var getLocations: GetLocationsProtocol!
	var getCurrentLocation: GetCurrentLocationProtocol!

	// MARK: - Properties
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.isHidden = true
		setupCollectionView()
		populateSearchData()
		headerView.searchBar.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
}

// MARK: - Private Methods
private extension SearchViewController {
	func populateSearchData() {
        Spinner.start(from: self.view,
                      style: .whiteLarge,
                      backgroundColor: .clear,
                      baseColor: .blue)
		getCurrentLocation.invoke { [weak self] position in
			guard let self = self else { return }
			self.getLocations.invoke(with: position) { locations in
				self.dataSource.locations = locations
				DispatchQueue.main.async {
                    Spinner.stop()
					self.collectionView.reloadData()
					self.collectionView.isHidden = false
				}
			}
		}
	}

	func setupCollectionView() {
		collectionView.delegate = delegate
		collectionView.dataSource = dataSource
		collectionViewLayout.sectionInset = UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
		collectionViewLayout.minimumLineSpacing = Constants.spacing
		collectionViewLayout.minimumInteritemSpacing = Constants.spacing
		collectionView.collectionViewLayout = collectionViewLayout
	}
}

extension SearchViewController: UITextFieldDelegate {
	@objc
	func textDidChange(_ textField: UITextField) {
		let text = textField.text ?? ""
		if text.isEmpty {
			dataSource.isSearching = false
			collectionView.reloadData()
		}

		if text.count > 2 {
			dataSource.isSearching = true
			getLocations.invoke(with: text) { [weak self] locations in
				self?.dataSource.filteredLocations = locations
				DispatchQueue.main.async {
					self?.collectionView.reloadData()
				}
			}
		}
	}
}
