//
//  SettingsViewController.swift
//  JourTrip
//
//  Created by Alexandre on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        print(image)
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    var userProfile: Profile? = nil
    var imagePicker: ImagePicker!
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
        
        tableView.separatorStyle = .none
    }

    // MARK: - Actions
    @objc func cancelAction(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceSection().count
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var hola = ""
        switch section {
        case 1:
            hola = "User data"
        case 2:
            hola = "Settings"
        default:
            hola = ""
        }
        
        return hola
    }
    
//    func selectPicker() {
//        let pickerController = UIImagePickerController()
//        pickerController.delegate = self
//        pickerController.allowsEditing = true
//        pickerController.mediaTypes = ["public.image"]
//        pickerController.sourceType = .camera
//    }
    
//    func dataSourceRows() -> NSArray {
//
//        let data = [[["Test 1" : JourTripImages.profileTabBar()]] as [Any]
//
//        return data as NSArray
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // section 1= 1 row
            return 1
//
//        let data = dataSourceRows()
//        let section = data[section] as! NSArray
//
//        return section.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserSettingsTableViewCell", for: indexPath) as! UserSettingsTableViewCell
            cell.setup(with: userProfile?.fullname ?? "",
                       userName: userProfile?.username ?? "",
                       email: userProfile?.email ?? "")
            cell.selectionStyle = .none
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePasswordTableViewCell", for: indexPath) as! ChangePasswordTableViewCell
            
            return cell
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return PhotoSettingsTableViewCell.preferredHeight()
            case 1:
                return UserSettingsTableViewCell.preferredHeight()
            case 2:
                return ChangePasswordTableViewCell.preferredHeight()
                
            default:
                return UITableView.automaticDimension
            }
            
        default:
             return UITableView.automaticDimension
        }
//         return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            imagePicker.present(from: self.view)
        }
    }
    
    func dataSourceSection() -> NSArray {
        let data = ["", "ACCOUNT DETAILS", "Change Password"]
//        let data = ["",
//                    EelpTranslator.localized(string: "profile_paymentMethod").uppercased(),
//                    EelpTranslator.localized(string: "profile_membership").uppercased(),
//                    EelpTranslator.localized(string: "profile_suggest").uppercased(),
//                    EelpTranslator.localized(string: "profile_frequentQuestions").uppercased(),
//                    EelpTranslator.localized(string: "profile_closeSession")
//        ]
//
        return data as NSArray
    }
}
