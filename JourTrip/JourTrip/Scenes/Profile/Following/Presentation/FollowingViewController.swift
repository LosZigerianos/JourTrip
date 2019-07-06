//
//  FollowingViewController.swift
//  JourTrip
//
//  Created by Alexandre on 04/07/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class FollowingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    var followingUsers: [Profile]!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupUI()
       
    }
    
    // MARK: - Private
    private func setupUI() {
        //        navigationController?.navigationBar.titleTextAttributes =
        //            [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
        //             NSAttributedString.Key.font: JourTripFont.fontMedium(ofSize: 21)]
        title = "Following"
        
        //        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(sender:)))
        
        //        navigationItem.setRightBarButtonItems([cancelItem], animated: true)
        
        let followingCell = UINib(nibName: "FollowingTableViewCell", bundle: nil)
        tableView.register(followingCell, forCellReuseIdentifier: "FollowingTableViewCell")
    }
    
}

extension FollowingViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension FollowingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = followingUsers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingTableViewCell", for: indexPath) as! FollowingTableViewCell
        cell.setup(with: user.username ?? "", userImage: user.photo ?? "")
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        //            let changePasswordViewController = ChangePasswordViewController()
        //            navigationController?.pushViewController(changePasswordViewController, animated: true)
    }
    
}

