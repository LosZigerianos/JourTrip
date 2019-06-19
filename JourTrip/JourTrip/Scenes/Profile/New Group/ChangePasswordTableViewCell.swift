//
//  SavePasswordTableViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class ChangePasswordTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func preferredHeight() -> CGFloat {
        return ChangePasswordTableViewCell().contentView.frame.width
    }
    
}
