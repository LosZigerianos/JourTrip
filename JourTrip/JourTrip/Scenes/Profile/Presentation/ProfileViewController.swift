//
//  ProfileViewController.swift
//  JourTrip
//
//  Created by Alexandre on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Constants
    enum CellConstants {
        static let columns: CGFloat = 1
        static let spacing: CGFloat = 8
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var getProfile: GetProfileProtocol!
    var getFollowers: GetFollowersProtocol!
    var userProfile: Profile?
    var userComments = [Comment]()
    var following = [Profile]()
    var detailNavigator: FeedDetailNavigatorProtocol!
    
    var location: Location?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        getFollowers.invoke() { [weak self] profile in
            guard let self = self else { return }
            if let profiles = profile.data {
                self.following = profiles
            } else {
                self.following = []
            }
        }
        
        Spinner.start(from: self.view,
                      style: .whiteLarge,
                      backgroundColor: .clear,
                      baseColor: .blue)
        
        getProfile.invoke(with: "") { [weak self] profile in
            guard let self = self else { return }
            if let error = profile.error {
                // TODO: show alert
                print(error)
            } else {
                guard let profile: Profile = profile.data,
                    let comments = profile.comments else {
                        fatalError("profile data error")
                }
                self.userProfile = profile
                self.userComments = comments
                DispatchQueue.main.async {
                    Spinner.stop()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - UI
    private func setupUI() {
        setupNavigationBar()
        setupRightBarButtonItems()
        setupCollectionCells()
    }
    
    private func setupCollectionCells() {
        let profileCell = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        collectionView.register(profileCell, forCellWithReuseIdentifier: "ProfileTableViewCell")
        
        let nib = UINib(nibName: "FeedCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "FeedCollectionViewCell")
        
        collectionViewLayout.sectionInset = UIEdgeInsets(top: CellConstants.spacing,
                                                         left: CellConstants.spacing,
                                                         bottom: CellConstants.spacing,
                                                         right: CellConstants.spacing)
        
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    private func setupRightBarButtonItems() {
        let settingButton = UIButton(type: .custom)
        settingButton.setImage(UIImage(named: "settings"), for: .normal)
        //settingButton.addTarget(self, action: #selector(settingsAction(sender:)), for: .touchUpInside)
        let settingItem = UIBarButtonItem(customView: settingButton)
        
        let friendsButton = UIButton(type: .custom)
        friendsButton.setImage(UIImage(named: "search"), for: .normal)
      //  friendsButton.addTarget(self, action: #selector(friendsAction(sender:)), for: .touchUpInside)
        let friendItem = UIBarButtonItem(customView: friendsButton)
        friendItem.tintColor = .yellow
        
        navigationItem.setRightBarButtonItems([settingItem, friendItem], animated: true)
    }
    
    // MARK: - Services
    func deleteComment(with comment: Comment, indexPath: IndexPath) {
        getProfile.deleteComment(with: comment.id) { (response) in
            if response.data != nil {
                DispatchQueue.main.async {
                    self.collectionView.performBatchUpdates({
                        if let index = self.userComments.index(of: comment) {
                            self.userComments.remove(at: index)
                            let commentIndexPath = IndexPath(row: indexPath.row - 1, section: 0)
                            self.collectionView.deleteItems(at: [commentIndexPath])
                            self.collectionView.reloadItems(at: [indexPath])
                        }
                    }) { (finished) in
                        print(finished)
                    }
                }
            } else {
                print("\(String(describing: response.error))")
            }
        }
    }
    
    // MARK: - Actions
    @objc func friendsAction(sender: UIBarButtonItem) {
        let friendsViewController = FriendsViewController()
        navigationController?.pushViewController(friendsViewController, animated: true)
    }
    
    @objc func settingsAction(sender: UIBarButtonItem) {
        let settingsViewController = SettingsViewController()
        settingsViewController.userProfile = userProfile
        let nc = UINavigationController(rootViewController: settingsViewController)
        present(nc, animated: true, completion: nil)
    }
    
    private func alertActionSheet(with comment: Comment, indexPath: IndexPath) {
        //TODO: LocazidedStrings
        let alertController = UIAlertController(title: "Choose an option", message: "What do you want to do?", preferredStyle: .actionSheet)
        
//        let viewAction = UIAlertAction(title: "View comment", style: .default, handler: { (alert: UIAlertAction!) -> Void in
//            //self.detailNavigator.presentDetail(with: comment)
//        })
        let removeAction = UIAlertAction(title: "Remove it", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            self.deleteComment(with: comment, indexPath: indexPath)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            print(alert)
        }
        
//        alertController.addAction(viewAction)
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: stackViewActions!
    @objc func followingStackViewTapped() {
        let followingViewController = FollowingViewController()
        followingViewController.followingUsers = following
        navigationController?.pushViewController(followingViewController, animated: true)
    }
    
    @objc func followersStackViewTapped() {
        print("followersAction")
    }
    
    @objc func postsStackViewTapped() {
        print("posts")
    }
    
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userComments.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            cell.setup(with: userProfile?.username,
                       account: userProfile?.fullname,
                       imageURL: URL(string: userProfile?.photo ?? ""),
                       following: String(userProfile?.following ?? 0),
                       followers: String(userProfile?.followers ?? 0),
                       posts: String(userProfile?.comments?.count ?? 0))

            let followingTap = UITapGestureRecognizer(target: self, action: #selector(followingStackViewTapped))
            cell.followingStackView.addGestureRecognizer(followingTap)
            let followersTap = UITapGestureRecognizer(target: self, action: #selector(followersStackViewTapped))
            cell.followersStackView.addGestureRecognizer(followersTap)
            let postsTap = UITapGestureRecognizer(target: self, action: #selector(postsStackViewTapped))
            cell.postsStackView.addGestureRecognizer(postsTap)
            
            return cell
            
        } else {
            
            let comment = userComments[(indexPath.row - 1)]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as! FeedCollectionViewCell
            cell.configure(with: comment)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            print("User tapped on row \(String(describing: userComments[(indexPath.row - 1)].id))")
            alertActionSheet(with: userComments[indexPath.row - 1], indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width)
        
        if indexPath.row == 0 {
            return CGSize(width: width, height: width)
        } else {
            let totalSpacing = (2 * CellConstants.spacing) + (CellConstants.spacing)
            
            let commentWidth = width - totalSpacing
            return CGSize(width: commentWidth, height: commentWidth * 1.3)
        }
    }
}
