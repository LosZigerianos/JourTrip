//
//  ChangePasswordViewController.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Password"
        
        setupUI()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        let passwordCell = UINib(nibName: "PasswordTableViewCell", bundle: nil)
        tableView.register(passwordCell, forCellReuseIdentifier: "PasswordTableViewCell")
        
        tableView.separatorStyle = .none
    }
    
}

extension ChangePasswordViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ChangePasswordViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Update Password"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordTableViewCell", for: indexPath) as! PasswordTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return PasswordTableViewCell.preferredHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if indexPath.section == 0 && indexPath.row == 0 {
//            ImagePicker.present(from: self.view)
//        }
//        else if indexPath.section == 2 && indexPath.row == 0 {
//            let changePasswordViewController = ChangePasswordViewController()
//            navigationController?.pushViewController(changePasswordViewController, animated: true)
//        }
    }
    
//    func dataSourceSection() -> NSArray {
//        let data = ["", "ACCOUNT DETAILS", "Change Password"]
//
//        return data as NSArray
//    }
}
