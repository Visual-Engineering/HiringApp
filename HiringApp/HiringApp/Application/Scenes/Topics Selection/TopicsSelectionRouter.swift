//
//  TopicsSelectionRouter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class TopicsSelectionRouter {

    //MARK: - Stored properties
    unowned let view: TopicsSelectionViewController

    //MARK: Initializer
    init(view: TopicsSelectionViewController) {
        self.view = view
    }
}

extension TopicsSelectionRouter: TopicsSelectionRouterProtocol {

    func navigateToNextScene() {

    }
}
