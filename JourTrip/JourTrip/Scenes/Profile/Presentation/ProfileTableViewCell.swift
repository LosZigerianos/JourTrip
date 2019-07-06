//
//  ProfileTableViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 08/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Kingfisher

//TODO: Refactor name
class ProfileTableViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: self)
    
    // MARK: - Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var accountLabel: UILabel!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var followingValueLabel: UILabel!
    @IBOutlet var followerValueLabel: UILabel!
    @IBOutlet var postsValueLabel: UILabel!
    @IBOutlet var followingStackView: UIStackView!
    @IBOutlet var followersStackView: UIStackView!
    @IBOutlet var postsStackView: UIStackView!
    
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
