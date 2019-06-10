//
//  ProfileViewController.swift
//  JourTrip
//
//  Created by Alexandre on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView! {
        didSet {
            let profileCell = UINib(nibName: "ProfileTableViewCell", bundle: nil)
            tableView.register(profileCell, forCellReuseIdentifier: "ProfileTableViewCell")
            
            let locationCell = UINib(nibName: "ProfileLocationTableViewCell", bundle: nil)
            tableView.register(locationCell, forCellReuseIdentifier: "ProfileLocationTableViewCell")
        }
    }
    var getProfile: GetProfileProtocol!
    var userProfile: Profile?
    var userComments = [Comment]()
    var location: Location?
    var isDataReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getProfile.invoke(with: "") { [weak self] profile in
			guard let self = self else { return }
            if let error = profile.error {
                // TODO: show alert
                print(error)
            } else {
                // TODO: locationsss
                guard let profile: Profile = profile.data,
                    let comments = profile.comments else {
                        fatalError("profile data error")
                }
                self.userProfile = profile
                self.userComments = comments
                self.isDataReady = true
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
            }
        }
    }
    
    private func setupUI() {
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userComments.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 268.0
        } else {
            return 225.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isDataReady {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
                guard let username = userProfile?.username,
                    let following = userProfile?.following,
                    let followers = userProfile?.followers,
                    let fullName = userProfile?.fullname,
                    let userPhoto = userProfile?.photo,
                    let url = URL(string: userPhoto) else {
                        return UITableViewCell()
                }
                cell.setup(with: "@\(username)",
                           account: fullName,
                           imageURL: url,
                           following: "\(following)",
                    followers: "\(followers)",
                    posts: "0")
                
                return cell
            } else {
                let comment = userComments[(indexPath.row - 1)]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLocationTableViewCell",
                                                         for: indexPath) as! ProfileLocationTableViewCell
                
                guard let commentDescription = comment.commentDescription,
                    let location = comment.location,
                    let creationDate = comment.creationDate else {
                        fatalError("comment error!")
                }
                guard let name = location.name,
                    let address = location.address,
                    let photo = location.photos?.first,
                    let url = URL(string: photo),
                    let tag = location.tags?.first else {
                        fatalError("location error!")
                }
                
                cell.setup(with: name,
                           address: address,
                           locationURL: url,
                           tag: tag,
                           description: commentDescription,
                           creationDate: creationDate)
            }
        }
        
        return UITableViewCell()
    }
}
