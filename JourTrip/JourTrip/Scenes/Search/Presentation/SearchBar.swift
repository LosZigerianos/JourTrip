//
//  SearchBar.swift
//  JourTrip
//
//  Created by Adrián Silva on 29/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class SearchBar: UITextField {

	override init(frame: CGRect) {
		super.init(frame: frame)
		sharedInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		sharedInit()
	}
}

private extension SearchBar {
	func sharedInit() {
		setupLayer()
		setupText()
		setupLeftView()
	}

	func setupText() {
		font = UIFont(name: "Apercu-Medium", size: 16)
		textColor = .dustyGray
		tintColor = .dustyGray
		backgroundColor = .white
	}

	func setupLeftView() {
		leftViewMode = .always
		let leftViewContainer = UIView(frame: .init(x: 0, y: 0, width: 52, height: 40))
		let searchImageView = UIImageView(frame: .init(x: 16, y: 10, width: 20, height: 20))
		searchImageView.image = #imageLiteral(resourceName: "search")
		searchImageView.contentMode = .scaleAspectFit
		leftViewContainer.addSubview(searchImageView)
		leftView = leftViewContainer
	}

	func setupLayer() {
		layer.cornerRadius = 8
		layer.borderWidth = 1.0
		layer.borderColor = UIColor.clear.cgColor
		layer.masksToBounds = false
		layer.shadowOpacity = 0.23
		layer.shadowRadius = 12
		layer.shadowOffset = CGSize(width: 0, height: 0)
		layer.shadowColor = UIColor.black.cgColor
	}
}
