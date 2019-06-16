//
//  TagCollectionViewCell.swift
//  JourTrip
//
//  Created by Adrián Silva on 16/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
	static let reuseIdentifier = String(describing: self)

	@IBOutlet weak var tagLabel: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
		contentView.backgroundColor = UIColor.random()
		contentView.layer.cornerRadius = 16
		contentView.layer.borderWidth = 1.0
		contentView.layer.borderColor = UIColor.clear.cgColor
		contentView.layer.masksToBounds = true
    }

	func configure(with tag: String?) {
		tagLabel.text = tag?.uppercased()
	}
}
