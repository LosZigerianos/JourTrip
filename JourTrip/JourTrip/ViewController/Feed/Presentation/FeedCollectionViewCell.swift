//
//  FeedCollectionViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 10/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "FeedCollectionViewCell"
    
    // MARK: - Outlets
	@IBOutlet weak var tagCollectionView: UICollectionView!
	@IBOutlet weak var locationImageView: UIImageView! {
		didSet {
			locationImageView.clipsToBounds = true
		}
	}
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!

	var tags = [String]() {
		didSet {
			tagCollectionView.reloadData()
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()

		let nib = UINib(nibName: "TagCollectionViewCell", bundle: nil)
		tagCollectionView.register(nib, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
		tagCollectionView.delegate = self
		tagCollectionView.dataSource = self
		userImageView.layer.cornerRadius = 14
		userImageView.layer.masksToBounds = true
		setupLayer()
	}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        locationImageView.image = nil
        nameLabel.text = nil
        cityLabel.text = nil
        userImageView.image = nil
        userNameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func setupLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    }

	func configure(with data: Comment) {
		tags = data.location?.tags ?? []
		cityLabel.text = data.location?.city
		nameLabel.text = data.location?.name
		descriptionLabel.text = data.description
		userNameLabel.text = data.user?.fullname
		if let userImageString = data.user?.photo {
			userImageView.kf.setImage(with: URL(string: userImageString))
		}
		if let locationImageString = data.location?.photos?.first {
			locationImageView.kf.setImage(with: URL(string: locationImageString))
		}
	}
}

extension FeedCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return tags.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let tag = tags[indexPath.row]

		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }

		cell.configure(with: tag)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let tag = tags[indexPath.row]

		let textSize = tag
			.uppercased()
			.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "Apercu-Medium", size: 13)])
		return .init(width: textSize.width * 1.35, height: 32)
	}
}
