//
//  FeedService.swift
//  JourTrip
//
//  Created by Alexandre on 10/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol FeedService {
    func getTimeline(completion: @escaping (_ response: FeedResponse?, _ error: Error?) -> Void)
}

