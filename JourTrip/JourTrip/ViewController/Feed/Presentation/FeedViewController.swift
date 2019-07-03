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
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Constants
    enum Constants {
        static let columns: CGFloat = 1
        static let spacing: CGFloat = 8
    }
    
    // MARK: - Properties
    var getTimeline: GetTimelineProtocol!
	var detailNavigator: FeedDetailNavigatorProtocol!
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var comments = [Comment]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		let nib = UINib(nibName: "FeedCollectionViewCell", bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)

        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        Spinner.start(from: self.view,
                      style: .whiteLarge,
                      backgroundColor: .clear,
                      baseColor: .blue)
        
        getTimeline.invoke(with: "") { [weak self] comments in
            self?.comments = comments
			DispatchQueue.main.async {
                Spinner.stop()
				self?.collectionView.reloadData()
			}
        }
    }

    // MARK: - UI
    func setupUI() {
        collectionViewLayout.sectionInset = UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
        collectionView.collectionViewLayout = collectionViewLayout
    }
}
extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let comment = comments[indexPath.row]
        
		guard let nearCell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier,
																for: indexPath) as? FeedCollectionViewCell else {
			return UICollectionViewCell()
		}
		nearCell.configure(with: comment)
        return nearCell
    }
    
    // MARK: - Delegate and Flow layout
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let comment = comments[indexPath.row]
		detailNavigator.presentDetail(with: comment)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let totalSpacing = (2 * Constants.spacing) + (Constants.spacing)
        
        let width = (collectionView.bounds.width) - totalSpacing
        return CGSize(width: width, height: width * 1.3)
    }
}
