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

final class SearchViewController: BaseViewController  {
    // MARK: - IBOutlet
    @IBOutlet weak var headerView: UIView!
    
    // MARK: - Constants
    enum Constants {
        static let columns: CGFloat = 2
    }
    // TODO: set from tabbar
    // MARK: - Properties
    var locationManager: CLLocationManager?
    var isSearching = false
    var userID = "5ce9c088996e2d101513ad1d"
    var user: Metadata?
    var locations: [Location] = [] // location.geometry.double.first
    var filteredLocations = [Location]()
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    lazy var searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search Timeline"
        bar.delegate = self
        bar.tintColor = .white
        bar.barTintColor = UIColor.gray
        bar.sizeToFit()
//        bar.translatesAutoresizingMaskIntoConstraints = false // check
        return bar
    }()
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "NearCollectionViewCell", bundle: nil)
            // Setup Header
            collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
            collectionView.register(nib, forCellWithReuseIdentifier: NearCollectionViewCell.reuseIdentifier)
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getNearLocations()
    }
    
    // MARK: - UI
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // setup layout
        let width = calculateItemCellWidth()
        collectionViewLayout.itemSize = CGSize(width: width, height: width)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.isHidden = false
        
        headerView.addSubview(searchBar)
        searchBar.sizeToFit()
        headerView.frame.size.height = searchBar.frame.size.height
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
    }
    
    func calculateItemCellWidth() -> CGFloat {
        let viewWidth = view.frame.width
        let spacing = (Constants.columns - 1) *
            collectionViewLayout.minimumInteritemSpacing
        let width = (viewWidth - spacing) / Constants.columns
        
        return width
    }
    
    // MARK: - Service proxy
    private func getNearLocations() {
        //        user = RealmManager.sharedInstance.getUser(with: userID)
        let token = DataManager.sharedInstance.loadValue(key: "token") as! String
        
        self.serviceProxy.getNearLocations(token: token, latitude: 41.6560593, longitude: -0.87734) { (locationResponse, error) in
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

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
        } else {
            isSearching = true
            filteredLocations = locations.filter({( location : Location) -> Bool in
                return (location.name?.lowercased().contains(searchText.lowercased()))!
            })
        }
        
        collectionView.reloadData()
    }
}

// MARK: - Collection delegate & datasource
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: searchBar.bounds.size.height)
    }
    
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
        guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell", for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }
        return reusableView
    }
}
