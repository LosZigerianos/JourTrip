//
//  ViewController.swift
//  JourTrip
//
//  Created by Alexandre on 26/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //TODO: lazy
    var serviceProxy: ServiceProxy = {
        return ServiceProxy()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
}
