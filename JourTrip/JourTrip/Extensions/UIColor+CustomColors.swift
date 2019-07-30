//
//  UIColor.swift
//  JourTrip
//
//  Created by Adrián Silva on 30/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

extension UIColor {
	static let dustyGray = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
	static let tundora = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    static let jourtripGray = #colorLiteral(red: 0.3161800504, green: 0.3373061419, blue: 0.4117352366, alpha: 1)
	static let jaffa = #colorLiteral(red: 0.9490196078, green: 0.4941176471, blue: 0.2392156863, alpha: 1)
	static let fern = #colorLiteral(red: 0.3764705882, green: 0.7254901961, blue: 0.4156862745, alpha: 1)
	static let danube = #colorLiteral(red: 0.3490196078, green: 0.568627451, blue: 0.7882352941, alpha: 1)
	static let redOrange = #colorLiteral(red: 0.968627451, green: 0.2235294118, blue: 0.2235294118, alpha: 1)
	static let seance = #colorLiteral(red: 0.6039215686, green: 0.07058823529, blue: 0.7019607843, alpha: 1)

    static func random() -> UIColor {
        let colors: [UIColor] = [.jaffa, .fern, .danube, .redOrange, seance]
        return colors[Int.random(in: 0...4)]
    }
}
