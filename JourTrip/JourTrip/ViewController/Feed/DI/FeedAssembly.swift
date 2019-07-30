//
//  FeedAssembly.swift
//  JourTrip
//
//  Created by Alexandre on 10/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

final class FeedAssembly {
    
    private let repository: FeedService
	private let feedDetailAssembly: FeedDetailAssembly
    
    init(repository: FeedService,
		 feedDetailAssembly: FeedDetailAssembly) {
        self.repository = repository
		self.feedDetailAssembly = feedDetailAssembly
    }
    
    func viewController() -> FeedViewController {
        let viewController = FeedViewController()
        viewController.getTimeline = getTimeline()
		viewController.detailNavigator = feedDetailAssembly.navigator()
        return viewController
    }
    
    func dataSource() -> SearchCollectionViewDataSource {
        return SearchCollectionViewDataSource()
    }
    
    func delegate() -> SearchCollectionViewDelegate {
        return SearchCollectionViewDelegate()
    }
    
    func getTimeline() -> GetTimelineProtocol {
        return GetTimeline(repository: repository)
    }
}
