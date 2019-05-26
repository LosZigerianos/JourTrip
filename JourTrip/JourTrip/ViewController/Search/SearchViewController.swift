//
//  SearchViewController.swift
//  JourTrip
//
//  Created by Alexandre on 20/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Kingfisher

final class SearchViewController: BaseViewController {
    
    // MARK: - Constants
    enum Constants {
        static let columns: CGFloat = 2
    }
    // TODO: set from tabbar
    // MARK: - Properties
    var userID = "5ce9c088996e2d101513ad1d"
    var user: Metadata?
    var locations: [Location] = []
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "NearCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: NearCollectionViewCell.reuseIdentifier)
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userID)
        setupUI()
        getNearLocations()
        
    }
    
    // MARK: - UI
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // setup layout
        let width = calculateItemWidth()
        collectionViewLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    func calculateItemWidth() -> CGFloat {
        let viewWidth = view.frame.width
        let spacing = (Constants.columns - 1) *
            collectionViewLayout.minimumInteritemSpacing
        let width = (viewWidth - spacing) / Constants.columns
        
        return width
        
    }
    
    private func configureTopView() {
        let topView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 120)
        topView.backgroundColor = .white
        
        self.view.addSubview(topView)
    }
    
    // MARK: - Service proxy
    private func getNearLocations() {
//        user = RealmManager.sharedInstance.getUser(with: userID)
        let token = DataManager.sharedInstance.loadValue(key: "token") as! String
        
        self.serviceProxy.getNearLocations(token: token, latitude: 41.6560593, longitude: -0.87734) { (locationResponse, error) in
            if error != nil {
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

// MARK: - Collection delegate & datasource
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nearLocation = locations[indexPath.row]
        let nearCell = collectionView.dequeueReusableCell(withReuseIdentifier: NearCollectionViewCell.reuseIdentifier, for: indexPath) as! NearCollectionViewCell
        nearCell.backgroundColor = UIColor.clear
        let url = URL(string: nearLocation.photos!.first!)
        nearCell.locationImageView.image = UIImage(named: "placeholder")
        nearCell.cityLabel.text = nearLocation.city
        nearCell.nameLabel.text = nearLocation.name

        return nearCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on row \(indexPath.row)")
    }
}
