//
//  SearchViewController.swift
//  JourTrip
//
//  Created by Alexandre on 20/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class SearchViewController: BaseViewController {
    // TODO: set from tabbar
    var userID = "5ce9c088996e2d101513ad1d"
    var user: Metadata?
    var locations: [Location] = []
    
    lazy var collectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: 180, height: 180)
        var c = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        c.backgroundColor = UIColor.white
        
        self.view.addSubview(c)

        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userID)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //configureTopView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNearLocations()
    }
    
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
        }
    }
    
    private func configureTopView() {
        let topView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 120)
        topView.backgroundColor = .white
        
        self.view.addSubview(topView)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let placeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        placeCell.backgroundColor = UIColor.gray
        
        return placeCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on row \(indexPath.row)")
    }
}
