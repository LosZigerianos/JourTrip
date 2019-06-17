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
	@IBOutlet weak var cardView: CommentCardView?

	override func awakeFromNib() {
		super.awakeFromNib()
		setupLayer()
	}
    
    override func prepareForReuse() {
        super.prepareForReuse()
		cardView?.prepareForReuse()
    }
    
    func setupLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    }

	func configure(with data: Comment) {
		cardView?.configure(with: data)
	}
}
