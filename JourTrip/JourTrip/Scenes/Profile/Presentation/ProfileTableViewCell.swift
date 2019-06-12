////
////  ProfileTableViewCell.swift
////  JourTrip
////
////  Created by Alexandre on 08/06/2019.
////  Copyright © 2019 Los Zigerianos. All rights reserved.
////

import UIKit
import Kingfisher

class ProfileTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: self)
    
    // MARK: - Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var accountLabel: UILabel!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var followingValueLabel: UILabel!
    @IBOutlet var followerValueLabel: UILabel!
    @IBOutlet var postsValueLabel: UILabel!
    @IBOutlet var followLabel: UILabel!
    @IBOutlet var followerLabel: UILabel!
    @IBOutlet var postsLabel: UILabel!

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}


    //TODO: localize languages and fix name/account
    func setup(with username: String?,
                    account: String?,
                    imageURL: URL?,
                    following: String?,
                    followers: String?,
                    posts: String?) {
        nameLabel.text = account
        accountLabel.text = "@\(username ?? "")"
        userImageView.kf.setImage(with: imageURL)
		userImageView.layer.masksToBounds = true
		userImageView.layer.cornerRadius = userImageView.frame.size.height / 2
        followingValueLabel.text = following
        followerValueLabel.text = followers
        postsValueLabel.text = posts
    }
}
