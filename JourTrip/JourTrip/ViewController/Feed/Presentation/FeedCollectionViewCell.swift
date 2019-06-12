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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
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
		cityLabel.text = data.location?.city
		nameLabel.text = data.location?.name
		descriptionLabel.text = data.location?.description
		userNameLabel.text = data.user?.fullname
		if let userImageString = data.user?.photo {
			userImageView.kf.setImage(with: URL(string: userImageString))
			userImageView.layer.cornerRadius = 14
			userImageView.layer.masksToBounds = true
		}
		if let locationImageString = data.location?.photos?.first {
			locationImageView.kf.setImage(with: URL(string: locationImageString))
		}

	}
}
