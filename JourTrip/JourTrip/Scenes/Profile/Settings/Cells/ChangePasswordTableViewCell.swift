//
//  SavePasswordTableViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class ChangePasswordTableViewCell: UITableViewCell {
    @IBOutlet var passwordView: UIView!

    @IBOutlet var changePasswordLabel: UILabel!
    
    class func preferredHeight() -> CGFloat {
        return 44.0
    }
    
}
