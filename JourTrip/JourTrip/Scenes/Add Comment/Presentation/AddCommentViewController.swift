//
//  AddCommentViewController.swift
//  JourTrip
//
//  Created by Adrián Silva on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol AddCommentViewControllerProvider: class {
	func viewController() -> AddCommentViewController
}

class AddCommentViewController: UIViewController {

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
		dismiss(animated: true)
	}

}
