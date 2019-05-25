//
//  MainTabBarController.swift
//  JourTrip
//
//  Created by Alexandre on 19/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol TabBarViewControllerProvider: class {
	func viewController() -> MainTabBarController
}

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
