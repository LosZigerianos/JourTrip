//
//  FeedViewController.swift
//  JourTrip
//
//  Created by Alexandre on 10/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "FeedCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
        }
    }
    
    // MARK: - Constants
    enum Constants {
        static let columns: CGFloat = 1
        static let spacing: CGFloat = 10
    }
    
    // MARK: - Properties
    var getTimeline: GetTimelineProtocol!
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var comments = [Comment]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getTimeline.invoke(with: "") { (comments) in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }

    // MARK: - UI
    func setupUI() {
        collectionViewLayout.sectionInset = UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
//        collectionViewLayout.minimumLineSpacing = Constants.spacing
//        collectionViewLayout.minimumInteritemSpacing = Constants.spacing
//        collectionViewLayout.headerReferenceSize = .init(width: view.frame.width, height: 150)
        collectionView.collectionViewLayout = collectionViewLayout
    }
}
extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var feed = comments[indexPath.row]
        
        let nearCell = collectionView.dequeueReusableCell(withReuseIdentifier: NearCollectionViewCell.reuseIdentifier, for: indexPath) as! FeedCollectionViewCell
        
        if let user = feed.user,
            let location = feed.location,
            let photo = location.photos?.first,
            let userPhoto = user.photo,
            let commentDescription = feed.commentDescription,
            let creationDate = feed.creationDate {
            nearCell.locationImageView.kf.setImage(with: URL(string:photo))
            nearCell.cityLabel.text = location.city
            nearCell.nameLabel.text = location.name
            nearCell.userImageView.kf.setImage(with: URL(string: userPhoto))
            nearCell.userMessage.text = commentDescription
            nearCell.userNameLabel.text = user.fullname
            
            return nearCell
        }
        
        return FeedCollectionViewCell()
    }
    
    // MARK: - Delegate and Flow layout
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on row \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let totalSpacing = (2 * Constants.spacing) + ((Constants.columns) * Constants.spacing)
        
        let width = (collectionView.bounds.width) - totalSpacing
        return CGSize(width: width, height: width)
    }
}
