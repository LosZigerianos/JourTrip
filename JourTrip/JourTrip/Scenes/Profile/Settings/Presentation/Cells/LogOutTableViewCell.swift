//
//  LogOutTableViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class LogOutTableViewCell: UITableViewCell {
    
    @IBOutlet var logOutButton: UIButton! {
        didSet {
            logOutButton.layer.cornerRadius = 18
            logOutButton.layer.borderWidth = 2.0
            logOutButton.layer.borderColor = UIColor.jourtripGray.cgColor
        }
    }
    
    class func preferredHeight() -> CGFloat {
        return LogOutTableViewCell().contentView.frame.width
    }
}
