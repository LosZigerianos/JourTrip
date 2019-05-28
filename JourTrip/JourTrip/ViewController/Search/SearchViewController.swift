//
//  SearchViewController.swift
//  JourTrip
//
//  Created by Alexandre on 20/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class SearchViewController: BaseViewController {
    
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
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //configureTopView()
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
        return 10
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
