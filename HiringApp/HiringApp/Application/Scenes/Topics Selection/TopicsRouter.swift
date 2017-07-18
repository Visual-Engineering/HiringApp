//
//  TopicsRouter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import HiringAppCore

class TopicsRouter {

    //MARK: - Stored properties
    unowned let view: TopicsViewController

    //MARK: Initializer
    init(view: TopicsViewController) {
        self.view = view
    }
}

extension TopicsRouter: TopicsRouterProtocol {

    func navigateToNextScene(selectedTopic: TopicViewModel) {
        
    }
}
