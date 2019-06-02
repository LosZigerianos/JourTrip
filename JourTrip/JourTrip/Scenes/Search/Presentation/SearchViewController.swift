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
			collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
			collectionView.register(nib, forCellWithReuseIdentifier: NearCollectionViewCell.reuseIdentifier)
		}
	}
    
	// MARK: - Constants
	enum Constants {
		static let columns: CGFloat = 2
		static let spacing: CGFloat = 8
	}

    // MARK: - Properties
    var locationManager: CLLocationManager?
	var dataSource: SearchCollectionViewDataSource!
	var delegate: SearchCollectionViewDelegate!
	var getNearLocations: GetNearLocationsProtocol!
    var latitude = 41.6560593
    var longitude = -0.87734
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		initializeLocationManager()
		setupUI()
		collectionView.delegate = delegate
		collectionView.dataSource = dataSource
		let position = Position(latitude: latitude, longitude: longitude)

		getNearLocations.invoke(with: position) { locations in
			self.dataSource.locations = locations
			self.collectionView.reloadData()
		}
    }
    
    // MARK: - UI
    func setupUI() {
		collectionViewLayout.sectionInset = UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
		collectionViewLayout.minimumLineSpacing = Constants.spacing
		collectionViewLayout.minimumInteritemSpacing = Constants.spacing
		collectionViewLayout.headerReferenceSize = .init(width: view.frame.width, height: 150)
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    // MARK: - Location Manager
    func initializeLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
}

// MARK: - LocationManager Delegate
extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // TODO: manage when user not authorize the location
        if status == .authorizedAlways {

        }
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
