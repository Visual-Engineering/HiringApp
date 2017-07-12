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
    let topics: [TopicModel]
    
    init(topics: [TopicModel]){
        self.topics = topics
    }
}

