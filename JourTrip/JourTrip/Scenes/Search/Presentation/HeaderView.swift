//  HeaderView.swift
//  JourTrip
//
//  Created by Alexandre on 27/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class HeaderView: UIView {
	lazy var searchBar: SearchBar = {
		let searchBar = SearchBar()
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		searchBar.placeholder = "Search for places"
		return searchBar
	}()

	lazy var headerLabel: UILabel = {
		let label = UILabel()
		label.font = JourTripFont.fontBold(ofSize: 24)
		label.textColor = .tundora
		label.text = "Nearby"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(frame: CGRect) {
        super.init(frame: frame)
		sharedInit()
    }
    
	required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		sharedInit()
    }
}

private extension HeaderView {
	func sharedInit() {
		addSubview(searchBar)
		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			searchBar.heightAnchor.constraint(equalToConstant: 52)
			])

		addSubview(headerLabel)
		NSLayoutConstraint.activate([
			headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
			])
	}
}
