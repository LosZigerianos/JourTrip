//
//  ProfileCell.swift
//  JourTrip
//
//  Created by Alexandre on 08/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    static let reuseIdentifier = String(describing: self)
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var accountLabel: UILabel!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var followValueLabel: UILabel!
    @IBOutlet var followerValueLabel: UILabel!
    @IBOutlet var postsValueLabel: UILabel!
    @IBOutlet var followLabel: UILabel!
    @IBOutlet var followerLabel: UILabel!
    @IBOutlet var postsLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, customString: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
       setupLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
        accountLabel.text = ""
        userImageView.image = nil
        followValueLabel.text = ""
        followerValueLabel.text = ""
        postsValueLabel.text = ""
        followLabel.text = ""
        followerLabel.text = ""
        postsLabel.text = ""
    }
    
    func setupLayer() {
       // contentView.layer.cornerRadius = 8
       // contentView.layer.borderWidth = 1.0
       // contentView.layer.borderColor = UIColor.clear.cgColor
       // contentView.layer.masksToBounds = true
    }
    
//    func configure(with notebook: Notebook) {
//        titleLabel.text = notebook.name
//        creationDateLabel.text = "Creado: \((notebook.creationDate as Date?)?.customStringLabel() ?? "ND")"
//    }
}
