//
//  AddReview.swift
//  JourTrip
//
//  Created by Adrián Silva on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol AddReviewProtocol {
	func invoke(comment: String, locationId: String, completion: @escaping (Void?, Error?) -> Void)
}

struct AddReview: AddReviewProtocol {

	private let repository: CommentService

	init(repository: CommentService) {
		self.repository = repository
	}

	func invoke(comment: String, locationId: String, completion: @escaping (Void?, Error?) -> Void) {
		repository.postComment(comment, locationId: locationId) { _, error in
			if let error = error {
				completion(nil, error)
			}

			completion((), nil)
		}
	}
}
