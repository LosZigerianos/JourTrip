//
//  CommentCardView.swift
//  JourTrip
//
//  Created by Adrián Silva on 16/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class CommentCardView: UIView {

	lazy var tagCollectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .clear
		let nib = UINib(nibName: "TagCollectionViewCell", bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
		collectionView.delegate = self
		collectionView.dataSource = self
		return collectionView
	}()

	lazy var locationImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	lazy var locationImageViewOverlay: UIView = {
		let view = UIView()
		view.backgroundColor = .darkGray
		view.alpha = 0.55
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = UIFont(name: "ApercuPro-Bold", size: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	lazy var cityLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = UIFont(name: "Apercu-Medium", size: 14)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	lazy var commentNameStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [nameLabel, cityLabel])
		stack.axis = .vertical
		stack.spacing = 2
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()

	lazy var userImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 14
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	lazy var userNameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Apercu-Regular", size: 14)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	lazy var userDataStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [userImageView, userNameLabel])
		stack.axis = .horizontal
		stack.spacing = 12
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()

	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Apercu-Regular", size: 12)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		return label
	}()

	lazy var commentDataStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [userDataStackView, descriptionLabel])
		stack.axis = .vertical
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = 6
		return stack
	}()

	lazy var bottomDataStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [tagCollectionView, commentDataStackView])
		stack.axis = .vertical
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = 12
		return stack
	}()

	var tags = [String]() {
		didSet {
			tagCollectionView.reloadData()
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		sharedInit()

	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		sharedInit()
	}

	func sharedInit() {
		addSubview(locationImageView)
		NSLayoutConstraint.activate([
			locationImageView.topAnchor.constraint(equalTo: topAnchor),
			locationImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			locationImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			locationImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
		])

		addSubview(locationImageViewOverlay)
		NSLayoutConstraint.activate([
			locationImageViewOverlay.topAnchor.constraint(equalTo: topAnchor),
			locationImageViewOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
			locationImageViewOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
			locationImageViewOverlay.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
		])

		addSubview(commentNameStackView)
		NSLayoutConstraint.activate([
			commentNameStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			commentNameStackView.bottomAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: -8),
		])

		addSubview(bottomDataStackView)
		NSLayoutConstraint.activate([
			bottomDataStackView.topAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: 8),
			bottomDataStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			bottomDataStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			bottomDataStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])

		tagCollectionView.heightAnchor.constraint(equalToConstant: 38).isActive = true
		userImageView.heightAnchor.constraint(equalToConstant: 27).isActive = true
		userImageView.widthAnchor.constraint(equalToConstant: 27).isActive = true
	}

	func configure(with data: Comment) {
		tags = data.location?.tags ?? []
		cityLabel.text = data.location?.city
		nameLabel.text = data.location?.name
		descriptionLabel.text = data.description
		userNameLabel.text = data.user?.fullname
		if let userImageString = data.user?.photo {
			userImageView.kf.setImage(with: URL(string: userImageString))
		}
		if let locationImageString = data.location?.photos?.first {
			locationImageView.kf.setImage(with: URL(string: locationImageString))
		}
	}

	func prepareForReuse() {
		locationImageView.image = nil
		nameLabel.text = nil
		cityLabel.text = nil
		userImageView.image = nil
		userNameLabel.text = nil
		descriptionLabel.text = nil
	}
}

extension CommentCardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return tags.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let tag = tags[indexPath.row]

		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }

		cell.configure(with: tag)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let tag = tags[indexPath.row]

		let textSize = tag
			.uppercased()
			.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "Apercu-Medium", size: 13)])
		return .init(width: textSize.width * 1.35, height: 32)
	}
}
