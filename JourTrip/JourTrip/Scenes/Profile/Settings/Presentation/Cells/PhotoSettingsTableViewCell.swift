//
//  PhotoSettingsTableViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoSettingsTableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!

    func setup(with imageURL: URL?) {
        userImageView.kf.setImage(with: imageURL)
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.size.height / 2
    }
    
    class func preferredHeight() -> CGFloat {
        return PhotoSettingsTableViewCell().contentView.frame.width
    }
}

extension PhotoSettingsTableViewCell: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        print("he seleccionado")
        userImageView.image = image
        //        self.imagePicker.image = image
    }
}
