//
//  TechSelectionRouter.swift
//  HiringApp
//
//  Created by Alejandro Garcia on 19/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class TechSelectionRouter {

    //MARK: - Stored properties
    unowned let view: TechSelectionViewController

    //MARK: Initializer
    init(view: TechSelectionViewController) {
        self.view = view
    }
}

extension TechSelectionRouter: TechSelectionRouterProtocol {

    func navigateToNextScene() {

    }
}
