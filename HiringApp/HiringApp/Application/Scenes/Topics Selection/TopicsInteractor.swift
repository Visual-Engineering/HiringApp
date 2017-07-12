//
//  TopicsInteractor.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred
import HiringAppCore

class TopicsInteractor {

    //MARK: - Stored properties
    let repository: TopicsRepositoryProtocol

    //MARK: - Initializer
    init(repository: TopicsRepositoryProtocol) {
        self.repository = repository
    }

}

extension TopicsInteractor: TopicsInteractorProtocol {

        func retrieveAPITopics(technologyId: Int) -> Task<[TopicModel]> {
            return repository.retrieveAPITopics(technologyId: technologyId)
        }
}
