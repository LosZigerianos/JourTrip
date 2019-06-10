//
//  FeedCollectionViewCell.swift
//  JourTrip
//
//  Created by Adrián Silva on 09/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var authorImage: UIImageView!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var reviewTextView: UITextView!
	@IBOutlet weak var tagsCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	prep

}
