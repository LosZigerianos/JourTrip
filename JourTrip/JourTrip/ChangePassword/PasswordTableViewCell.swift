//
//  PasswordTableViewCell.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class PasswordTableViewCell: UITableViewCell {
    // MARK: - Parameters
    let changePasswordViewController = ChangePasswordViewController()
    
    // MARK: - Outlets
    @IBOutlet var oldCustomTextField: CustomTextField! {
        didSet {
            oldCustomTextField.layer.cornerRadius = 10
        }
    }
    @IBOutlet var newCustomTextField: CustomTextField! {
        didSet {
            newCustomTextField.layer.cornerRadius = 10
        }
    }
    @IBOutlet var updatePasswordButton: UIButton! {
        
        didSet {
            updatePasswordButton.layer.cornerRadius = 18
        }
    }
    
    // MARK: - Actions
    @IBAction func updatePasswordAction(_ sender: UIButton) {
        guard let oldPassword = oldCustomTextField?.text,
            let newPassword = newCustomTextField.text else {
                return
        }
        
        changePasswordViewController.updatePassword(insteadOf: oldPassword, changeTo: newPassword)
    }
    
    // MARK: - UI
    class func preferredHeight() -> CGFloat {
        return PasswordTableViewCell().contentView.frame.width
    }
}
