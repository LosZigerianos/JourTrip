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

    //TODO: localize languages
    func setup(with username: String,
                    account: String,
                    imageURL: URL,
                    following: String,
                    followers: String,
                    posts: String) {
        nameLabel.text = username
        accountLabel.text = account
        userImageView.kf.setImage(with: imageURL)
        followingValueLabel.text = following
        followerValueLabel.text = followers
        postsValueLabel.text = posts
    }
}
