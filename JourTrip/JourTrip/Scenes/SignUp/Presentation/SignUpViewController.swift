//
//  SignUpViewController.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol SignUpViewControllerProvider: class {
    func signUpViewController() -> SignUpViewController
}

class SignUpViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var usernameTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.cornerRadius = 18
        }
    }
    @IBOutlet weak var googleSignUpButton: UIButton! {
        didSet {
            googleSignUpButton.layer.cornerRadius = 18
        }
    }

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerAppareance()
    }


    // MARK: - Actions
    @IBAction func signUpAction(_ sender: UIButton) {

    }

    @IBAction func googleSignUpAction(_ sender: UIButton) {

    }
}

private extension SignUpViewController {
    func setupNavigationControllerAppareance() {
        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("Sign Up", comment: "")
        titleLabel.font = UIFont(name: "Apercu Pro Bold", size: 18)
        titleLabel.textColor = #colorLiteral(red: 0.4117260575, green: 0.4117894173, blue: 0.4117122293, alpha: 1)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4117260575, green: 0.4117894173, blue: 0.4117122293, alpha: 1)
    }
}
