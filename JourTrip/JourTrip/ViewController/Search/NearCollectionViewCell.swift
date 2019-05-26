//
//  NearCell.swift
//  JourTrip
//
//  Created by Alexandre on 26/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class NearCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: self)
    
    // MARK: - Outlets
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        locationImageView.image = nil
        nameLabel.text = nil
        cityLabel.text = nil
    }
}
