//
//  SignUpViewController.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SignUpViewControllerProvider: class {
    func signUpViewController() -> SignUpViewController
}

class SignUpViewController: UIViewController {
	// MARK: - Private properties
	private let viewModel: SignUpViewModel
	private let navigator: TabBarNavigatorProtocol
	private let disposeBag = DisposeBag()

	// MARK: - Initializers
	init(viewModel: SignUpViewModel,
		 navigator: TabBarNavigatorProtocol) {
		self.viewModel = viewModel
		self.navigator = navigator
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


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
		viewModelBindings()
    }
}

private extension SignUpViewController {
    func setupNavigationControllerAppareance() {
        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("Sign Up", comment: "")
        titleLabel.font = JourTripFont.fontBold(ofSize: 18)
        titleLabel.textColor = #colorLiteral(red: 0.4117260575, green: 0.4117894173, blue: 0.4117122293, alpha: 1)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4117260575, green: 0.4117894173, blue: 0.4117122293, alpha: 1)
    }

	func viewModelBindings() {
		let inputs = SignUpViewModel.Inputs(name: nameTextField.rx.text.orEmpty.asObservable(),
											email: emailTextField.rx.text.orEmpty.asObservable(),
											username: usernameTextField.rx.text.orEmpty.asObservable(),
											password: passwordTextField.rx.text.orEmpty.asObservable(),
											buttonTap: signUpButton.rx.tap.asObservable())

		let outputs = viewModel.transform(inputs: inputs)

		outputs.buttonEnabled
			.drive(signUpButton.rx.isEnabled)
			.disposed(by: disposeBag)

		outputs.signUpSuccesful
			.drive(onNext: { [weak self] _ in
				self?.navigator.navigateToTabBar()
			})
			.disposed(by: disposeBag)
	}
}
