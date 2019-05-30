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

final class SearchViewController: BaseViewController {
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
    // TODO: set from tabbar
    // MARK: - Properties
    var locationManager: CLLocationManager?
    var isSearching = false
    var userID = "5ce9c088996e2d101513ad1d"
    var user: Metadata?
	var locations: [Location] = [] {
		didSet {
			collectionView.reloadData()
		}
	} // location.geometry.double.first
	var filteredLocations = [Location]() {
		didSet {
			collectionView.reloadData()
		}
	}
    var latitude = 41.6560593
    var longitude = -0.87734
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLocationManager()
        setupUI()
        getNearLocations()
    }
    
    // MARK: - UI
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionViewLayout.sectionInset = UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
		collectionViewLayout.minimumLineSpacing = Constants.spacing
		collectionViewLayout.minimumInteritemSpacing = Constants.spacing
		collectionViewLayout.headerReferenceSize = .init(width: view.frame.width, height: 150)
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.isHidden = false
    }
    
    // MARK: - Location Manager
    func initializeLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    // MARK: - Service proxy
    private func getNearLocations() {
        //        user = RealmManager.sharedInstance.getUser(with: userID)
        let token = DataManager.sharedInstance.loadValue(key: "token") as! String
        
        if let location = locationManager?.location {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
        
        self.serviceProxy.getNearLocations(token: token, latitude: latitude, longitude: longitude) { (locationResponse, error) in
            
            if error != nil {
                // FIXME: this is only for testing purposes
                fatalError("no locations provided")
            }
            
            guard let locations = locationResponse?.data else {
                return
            }
            
            self.locations = locations
            self.collectionView.reloadData()
        }
    }
}

// MARK: - LocationManager Delegate
extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // TODO: manage when user not authorize the location
        if status == .authorizedAlways {
            self.getNearLocations()
        }
    }
}

extension SearchViewController {
	@objc
	func textFieldEditingChanged(_ sender: UITextField) {
		let text = sender.text ?? ""
		if text.isEmpty {
			isSearching = false
			collectionView.reloadData()
		}

		if text.count > 2 {
			isSearching = true
			filteredLocations = locations.filter { location in
				(location.name?.lowercased().contains(text.lowercased()))!
			}
		}
	}
}

// MARK: - CollectionView Delegate Flow Layout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let totalSpacing = (2 * Constants.spacing) + ((Constants.columns - 1) * Constants.spacing)

		let width = (collectionView.bounds.width - totalSpacing) / Constants.columns
		return CGSize(width: width, height: width)
	}
}

// MARK: - Collection delegate & datasource
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on row \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }
		reusableView.searchBar.addTarget(self,
										 action: #selector(textFieldEditingChanged(_:)),
										 for: .editingChanged)
        return reusableView
    }
}
