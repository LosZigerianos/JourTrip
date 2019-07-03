//
//  SettingsViewController.swift
//  JourTrip
//
//  Created by Alexandre on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit


final class SettingsViewController: UIViewController, ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        print(image!)
    }
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    var userProfile: Profile? = nil
    var imagePicker: ImagePicker!
    var putUserData: PutUserDataProtocol!
    var onImageTap: ((_ image: String) -> Void)?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - UI
    private func setupUI() {
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
             NSAttributedString.Key.font: JourTripFont.fontMedium(ofSize: 21)]
        title = "User Profile"
        
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(sender:)))
        
        navigationItem.setRightBarButtonItems([cancelItem], animated: true)
        
        let photoCell = UINib(nibName: "PhotoSettingsTableViewCell", bundle: nil)
        tableView.register(photoCell, forCellReuseIdentifier: "PhotoSettingsTableViewCell")
        
        let userDataCell = UINib(nibName: "UserSettingsTableViewCell", bundle: nil)
        tableView.register(userDataCell, forCellReuseIdentifier: "UserSettingsTableViewCell")
        
        let changePasswordCell = UINib(nibName: "ChangePasswordTableViewCell", bundle: nil)
        tableView.register(changePasswordCell, forCellReuseIdentifier: "ChangePasswordTableViewCell")
        
        let logOutCell = UINib(nibName: "LogOutTableViewCell", bundle: nil)
        tableView.register(logOutCell, forCellReuseIdentifier: "LogOutTableViewCell")
        
        tableView.separatorStyle = .none
    }

    // MARK: - Actions
    @objc func cancelAction(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Services
//    func updateUserData(with comment: Comment, indexPath: IndexPath) {
    func updateUserData(with fullname: String , username: String, email: String) {
        print("HOOLA")
        
        putUserData.updateData(with: username, fullname: fullname, emai: email) { (response) in
            print(response)
        }
        
//        getProfile.deleteComment(with: comment.id) { (response) in
//            // TODO: show alert when something is wrong
//            if response.data != nil {
//                DispatchQueue.main.async {
//                    self.collectionView.performBatchUpdates({
//                        if let index = self.userComments.index(of: comment) {
//                            self.userComments.remove(at: index)
//                            let commentIndexPath = IndexPath(row: indexPath.row - 1, section: 0)
//                            self.collectionView.deleteItems(at: [commentIndexPath])
//                            self.collectionView.reloadItems(at: [indexPath])
//                        }
//                    }) { (finished) in
//                        print(finished)
//                    }
//                }
//            } else {
//                print("\(String(describing: response.error))")
//            }
//        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceSection().count
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titleInSection = ""
        switch section {
        case 1:
            titleInSection = "User data"
        case 2:
            titleInSection = "Settings"
        case 3:
            titleInSection = "Logout"
        default:
            titleInSection = ""
        }
        
        return titleInSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoSettingsTableViewCell", for: indexPath) as! PhotoSettingsTableViewCell
                cell.setup(with: URL(string: userProfile?.photo ?? ""))
                cell.selectionStyle = .none
                
                return cell
            }
        case 1:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserSettingsTableViewCell", for: indexPath) as! UserSettingsTableViewCell
                cell.setup(with: userProfile?.fullname ?? "",
                           userName: userProfile?.username ?? "",
                           email: userProfile?.email ?? "")
                cell.selectionStyle = .none
                
                return cell
            }
        
            
        case 2:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePasswordTableViewCell", for: indexPath) as! ChangePasswordTableViewCell
                
                cell.selectionStyle = .none
                
                return cell
            }
         
            
        case 3:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LogOutTableViewCell", for: indexPath) as! LogOutTableViewCell
                
                return cell
            }
           
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return PhotoSettingsTableViewCell.preferredHeight()
        case 1:
            return UserSettingsTableViewCell.preferredHeight()
        case 2:
            return 46.0
        case 3:
            return 46.0
        default:
             return 46.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            imagePicker.present(from: self.view)
        }
        else if indexPath.section == 2 && indexPath.row == 0 {
            let changePasswordViewController = ChangePasswordViewController()
            navigationController?.pushViewController(changePasswordViewController, animated: true)
        }
    }
    
    func dataSourceSection() -> NSArray {
        let data = ["", "ACCOUNT DETAILS", "Change Password", "Log out"]

        return data as NSArray
    }
}
