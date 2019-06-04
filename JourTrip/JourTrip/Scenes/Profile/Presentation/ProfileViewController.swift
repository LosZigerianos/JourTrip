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
    var getProfile: ProfileProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile.invoke(with: "5ceb706146e3c87667d594c2") { (profile) in
            print(profile)
        }
    }

}
