//
//  UserSettingsTableViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class UserSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet var userDataLabel: UILabel!
    @IBOutlet var fullnameCustomTextfield: CustomTextField!
    @IBOutlet var usernameCustomTextfield: CustomTextField!
    @IBOutlet var emailCustomTextfield: CustomTextField!
    @IBOutlet var updateDataButton: UIButton! {
        didSet {
            updateDataButton.layer.cornerRadius = 18
        }
    }
    
    func setup(with fullName: String,
               userName: String,
               email: String) {
        
        fullnameCustomTextfield.text = fullName
        usernameCustomTextfield.text = userName
        emailCustomTextfield.text = email
    }

    class func preferredHeight() -> CGFloat {
        return UserSettingsTableViewCell().contentView.frame.width
    }
    
}
