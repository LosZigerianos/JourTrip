//
//  CustomTextField.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppareance()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAppareance()
    }

    func setupAppareance() {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 0))
        leftViewMode = .always
    }
}
