//
//  WalkthroughRouter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class WalkthroughRouter {

    //MARK: - Stored properties
    unowned let view: WalkthroughViewController

    //MARK: Initializer
    init(view: WalkthroughViewController) {
        self.view = view
    }
}

extension WalkthroughRouter: WalkthroughRouterProtocol {

    func navigateToNextScene() {

    }
}
