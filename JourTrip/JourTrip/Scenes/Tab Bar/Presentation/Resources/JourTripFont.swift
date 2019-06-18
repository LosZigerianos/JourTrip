//
//  JourTripFont.swift
//  JourTrip
//
//  Created by Alexandre on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class JourTripFont: UIFont {
    
    class func fontBold(ofSize: CGFloat) -> UIFont {
        //        titleLabel.font = UIFont(name: "Apercu Pro Bold", size: 18)

        return UIFont(name: "Apercu Pro Bold", size: ofSize)!
    }
    
    class func fontMedium(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Apercu-Medium", size: ofSize)!
    }
    
    class func fontRegular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Apercu-Regular", size: ofSize)!
    }
    
    class func fontItalic(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Apercu Pro Italic", size: ofSize)!
    }
}
