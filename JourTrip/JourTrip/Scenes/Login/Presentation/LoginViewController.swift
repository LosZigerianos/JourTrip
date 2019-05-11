//
//  LoginViewController.swift
//  JourTrip
//
//  Created by Adrián Silva on 02/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel: LoginViewModel
    private let disposeBag = DisposeBag()

    // MARK: - Initializers
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAppareance()
        viewModelBindings()
    }
}

// MARK: - Private Methods
private extension LoginViewController {
    func setupButtonAppareance() {
        loginButton.layer.cornerRadius = 18
        googleLoginButton.layer.cornerRadius = 18
    }

    /// Binds the View with the ViewModel
    func viewModelBindings() {
        let inputs = LoginViewModel.Inputs(emailText: emailTextField.rx.text.orEmpty.asObservable(),
                                           passwordText: passwordTextField.rx.text.orEmpty.asObservable(),
                                           buttonTap: loginButton.rx.tap.asObservable())

        let outputs = viewModel.transform(inputs: inputs)

        outputs.buttonEnabled
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        outputs.loginSuccessful
            .drive(onNext: { _ in
                print("Login Successful")
            })
            .disposed(by: disposeBag)
    }
}
