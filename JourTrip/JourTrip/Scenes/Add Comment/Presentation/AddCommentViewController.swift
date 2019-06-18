//
//  AddCommentViewController.swift
//  JourTrip
//
//  Created by Adrián Silva on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol AddCommentViewControllerProvider: class {
	func viewController(with comment: Comment) -> AddCommentViewController
}

class AddCommentViewController: UIViewController {

	private let addComment: AddReviewProtocol
	private let comment: Comment

	init(addComment: AddReviewProtocol,
		 comment: Comment) {
		self.addComment = addComment
		self.comment = comment
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet weak var commentTextView: UITextView!
	@IBOutlet weak var submitButton: UIButton! {
		didSet {
			submitButton.layer.cornerRadius = 18
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func closeAction(_ sender: UIButton) {
		dismiss(animated: true)
	}

	@IBAction func submitAction(_ sender: UIButton) {
		addComment.invoke(comment: commentTextView.text, locationId: comment.location?.id ?? "") { [weak self] _, error in
			if let _ = error {
				print("Error")
			}

			self?.dismiss(animated: true)
		}
	}

}
