//
//  TopicsViewModel.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import HiringAppCore

struct TopicsViewModel {
    let topics: [TopicViewModel]
    
    init(topics: [TopicViewModel]) {
        self.topics = topics
    }
}

struct TopicViewModel {
    public let title: String
}

extension TopicModel {
    func toViewModel() -> TopicViewModel {
        let topicViewModel = TopicViewModel(title: self.title)
        return topicViewModel
    }
}
