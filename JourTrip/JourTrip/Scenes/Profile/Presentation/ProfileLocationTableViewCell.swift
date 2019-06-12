//
//  ProfileLocationTableViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 09/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileLocationTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: self)
    
    // MARK: - Outlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet var addressDescriptionLabel: UILabel!
    @IBOutlet private var locationImageView: UIImageView!
    @IBOutlet private var tagLabel: UILabel!
    @IBOutlet private  var descriptionLabel: UILabel!
    @IBOutlet private  var creationDateLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        locationImageView.image = nil
        titleLabel.text = nil
        addressDescriptionLabel.text = nil
        tagLabel.text = nil
        descriptionLabel.text = nil
        creationDateLabel.text = nil
    }
    
    //TODO: localize languages
    func setup(with title: String?,
               address: String?,
               locationURL: URL?,
               tag: String?,
               description: String?,
               creationDate: String?) {
        selectionStyle = .none
        titleLabel.text = title
        addressDescriptionLabel.text = address
		locationImageView.kf.setImage(with: locationURL)
		contentView.layer.cornerRadius = 8
		contentView.layer.borderWidth = 1.0
		contentView.layer.borderColor = UIColor.clear.cgColor
		contentView.layer.masksToBounds = true
//        tagLabel.text = tag
//        descriptionLabel.text = description
//        creationDateLabel.text = creationDate
    }

	override func layoutSubviews() {
		super.layoutSubviews()

		contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
	}
}
