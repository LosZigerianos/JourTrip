//
//  FeedDetailViewController.swift
//  JourTrip
//
//  Created by Adrián Silva on 16/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol FeedDetailViewControllerProvider: class {
	func viewController(with model: Comment) -> FeedDetailViewController
}

class FeedDetailViewController: UIViewController {
	private let comment: Comment

	@IBOutlet weak var commentView: CommentCardView!

	init(comment: Comment) {
		self.comment = comment
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        commentView.configure(with: comment)
    }

	@IBAction func closeButtonAction(_ sender: Any) {
		dismiss(animated: true)
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}
