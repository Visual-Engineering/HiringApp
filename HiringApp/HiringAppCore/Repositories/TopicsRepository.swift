
//
//  TopicsReposiroty.swift
//  Pods
//
//  Created by Santi Bernaldo on 12/07/2017.
//
//

import Foundation
import Deferred
import BSWFoundation


public protocol TopicsRepositoryProtocol {
    func retrieveAPITopics(technologyId: Int) -> Task<[TopicModel]>
}

public class TopicsRepository {
    
    // MARK: - Stored properties
    let apiProvider: APIProviderType
    let cacheProvider: CacheProviderType
    
    public init(apiProvider: APIProviderType = APIProvider(),
                cacheProvider: CacheProviderType = CacheProvider()) {
        
        self.apiProvider = apiProvider
        self.cacheProvider = cacheProvider
    }
}

extension TopicsRepository: TopicsRepositoryProtocol {
    
    public func retrieveAPITopics(technologyId: Int) -> Task<[TopicModel]> {
        if let topics = cacheProvider.getTopics() {
            return Task(success: topics)
        }
        
        let topicTask = apiProvider.retrieveTopics(technologyId: technologyId).andThen(upon: .main) { (modelsArray) -> Task<[TopicModel]> in
            return self.cacheProvider
                .saveTopics(modelsArray) //Save modelsArray into cache
                .recover(upon: .main, substituting: { (_) in })
                .map(upon: .main, transform: { (_) -> [TopicModel] in
                    return modelsArray
                })
        }
        
        return topicTask
    }

}
