//
//  FeedAssembly.swift
//  JourTrip
//
//  Created by Alexandre on 10/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

class FeedAssembly {
    
    private let repository: FeedService
    
    init(repository: FeedService) {
        self.repository = repository
    }
    
    func viewController() -> FeedViewController {
        let viewController = FeedViewController()
//        viewController.dataSource = dataSource()
//        viewController.delegate = delegate()
        viewController.getTimeline = getTimeline()
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
