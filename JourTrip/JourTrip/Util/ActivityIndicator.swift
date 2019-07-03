//
//  ActivityIndicator.swift
//  JourTrip
//
//  Created by Alexandre on 03/07/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class Spinner {
    fileprivate static var activityIndicator: UIActivityIndicatorView?
    fileprivate static var style: UIActivityIndicatorView.Style = .whiteLarge
    fileprivate static var baseBackColor = UIColor(white: 0, alpha: 0.6)
    fileprivate static var baseColor = UIColor.white
    
    /**
     Add spinner to `UIView`
     - Parameters:
     - view: The `UIView` being used to add the `UIActivityIndicatorView` onto
     - style: Style used for the `UIActivityIndicatorView`
     - backgroundColor: Display color
     - baseColor: Tint color of the spinner
     */
    public static func start(from view: UIView,
                           style: UIActivityIndicatorView.Style = Spinner.style,
                           backgroundColor: UIColor = Spinner.baseBackColor,
                           baseColor: UIColor = Spinner.baseColor) {
        
        guard Spinner.activityIndicator == nil else { return }
        
        let spinner = UIActivityIndicatorView(style: style)
        spinner.backgroundColor = backgroundColor
        spinner.color = baseColor
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        // Auto-layout constraints
        addConstraints(to: view, with: spinner)
        
        Spinner.activityIndicator = spinner
        Spinner.activityIndicator?.startAnimating()
    }
    
    /// Stops and removes `UIActivityIndicatorView`
    public static func stop() {
        Spinner.activityIndicator?.stopAnimating()
        Spinner.activityIndicator?.removeFromSuperview()
        Spinner.activityIndicator = nil
    }
    
    /**
     Add auto-layout constraints to provided `UIActivityIndicatorView`
     - Parameters:
     - view: The view used to provide layout constraints
     - spinner: The `UIActivityIndicatorView` used to display
     */
    fileprivate static func addConstraints(to view: UIView, with spinner: UIActivityIndicatorView) {
        spinner.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
}

