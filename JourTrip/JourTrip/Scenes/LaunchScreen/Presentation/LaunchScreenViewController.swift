//
//  LaunchScreenViewController.swift
//  JourTrip
//
//  Created by Adrián Silva on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LaunchScreenViewController: UIViewController {

	private let loginService: LoginServiceType
	private let launchScreenNavigator: LaunchScreenNavigatorProtocol
	private let disposeBag = DisposeBag()

	init(loginService: LoginServiceType,
		 launchScreenNavigator: LaunchScreenNavigatorProtocol) {
		self.loginService = loginService
		self.launchScreenNavigator = launchScreenNavigator
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		if let email = DataManager.sharedInstance.loadValue(key: ConstantsDataManager.email) as? String,
			let password = DataManager.sharedInstance.loadValue(key: ConstantsDataManager.password) as? String {
			let credentials = (email: email, password: password)

			loginService.login(with: credentials)
				.debug("Login")
				.observeOn(MainScheduler.instance)
				.subscribe(
					onSuccess: { [weak self] isSuccessful in
						self?.launchScreenNavigator.nextSceneAfterLogin(isSuccessful)
					},
					onError: { [weak self] _ in self?.launchScreenNavigator.nextSceneAfterLogin(false) })
				.disposed(by: disposeBag)
		} else {
			launchScreenNavigator.nextSceneAfterLogin(false)
		}
    }
}
