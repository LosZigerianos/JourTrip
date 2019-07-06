//
//  FollowingTableViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 04/07/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Kingfisher

class FollowingTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = 18
        }
    }
    @IBOutlet var userLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        userLabel.text = nil
    }
    
    // MARK: - Instance methods
    func setup(with userName: String, userImage: String) {
        userLabel.text = "@\(userName)"
        userImageView.kf.setImage(with: URL(string: userImage))
    }
    
    class func preferredHeight() -> CGFloat {
        return FollowingTableViewCell().contentView.frame.height
    }

}
