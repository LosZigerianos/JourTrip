//
//  InitialViewController.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol InitialViewControllerProvider: class {
	func viewController() -> InitialViewController
}

class InitialViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.cornerRadius = 18
        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 18
            loginButton.layer.borderWidth = 2
            loginButton.layer.borderColor = #colorLiteral(red: 0.3527634144, green: 0.3804193735, blue: 0.4549338222, alpha: 1)
        }
    }
    // MARK: - Private Properties
    private let viewModel: InitialViewModel

    // MARK: - Initializers
    init(viewModel: InitialViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Actions
    @IBAction func signUpAction(_ sender: UIButton) {
        viewModel.signupTapped()
    }

    @IBAction func loginAction(_ sender: UIButton) {
        viewModel.loginTapped()
    }
}
