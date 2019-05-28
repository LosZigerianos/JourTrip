//
//  ViewController.swift
//  JourTrip
//
//  Created by Alexandre on 26/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var serviceProxy: ServiceProxy = {
        return ServiceProxy()
    }()
    
    lazy var contentView : UIView = {
        return self.view
    }()
    
    lazy var tableView : UITableView = {
        var t = UITableView(frame:self.view.bounds, style: UITableView.Style.plain)
        
        t.backgroundColor = UIColor.white
        t.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        t.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.view.addSubview(t)
        
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
}
