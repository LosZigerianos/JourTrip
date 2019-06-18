//
//  CommentService.swift
//  JourTrip
//
//  Created by Adrián Silva on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol CommentService {
	func postComment(_ description: String,
					 locationId: String,
					 completion: @escaping (_ response: CommentResponse?, _ error: Error?) -> Void)
}
