//
//  ProfileViewController.swift
//  JourTrip
//
//  Created by Alexandre on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var getProfile: GetProfileProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile.invoke(with: "") { (profile) in
            print(profile)
        }
    }

}
