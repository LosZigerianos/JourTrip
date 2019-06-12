//
//  ProfileViewController.swift
//  JourTrip
//
//  Created by Alexandre on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()

    var getProfile: GetProfileProtocol!
    var userProfile: Profile?
    var userComments = [Comment]()
    var location: Location?
    
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
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
            }
        }
    }
    
    private func setupUI() {
		let profileCell = UINib(nibName: "ProfileTableViewCell", bundle: nil)
		tableView.register(profileCell, forCellReuseIdentifier: "ProfileTableViewCell")
		let locationCell = UINib(nibName: "ProfileLocationTableViewCell", bundle: nil)
		tableView.register(locationCell, forCellReuseIdentifier: "ProfileLocationTableViewCell")

        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
		tableView.allowsSelection = false
		tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
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
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
			cell.setup(with: userProfile?.username,
					   account: userProfile?.fullname,
					   imageURL: URL(string: userProfile?.photo ?? ""),
					   following: String(userProfile?.following ?? 0),
					   followers: String(userProfile?.followers ?? 0),
					   posts: String(userProfile?.comments?.count ?? 0))

			return cell
		} else {
			let comment = userComments[(indexPath.row - 1)]
			let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLocationTableViewCell",
													 for: indexPath) as! ProfileLocationTableViewCell

			cell.setup(with: comment.location?.name,
					   address: comment.location?.address,
					   locationURL: URL(string: comment.location?.photos?.first ?? ""),
					   tag: comment.location?.tags?.first ?? "",
					   description: comment.commentDescription,
					   creationDate: comment.creationDate)
		}

        return UITableViewCell()
    }
}
