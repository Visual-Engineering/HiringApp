//
//  AboutUsRouter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 13/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class AboutUsRouter {

    //MARK: - Stored properties
    unowned let view: AboutUsViewController

    //MARK: Initializer
    init(view: AboutUsViewController) {
        self.view = view
    }
}

extension AboutUsRouter: AboutUsRouterProtocol {

    func navigateToNextScene() {

    }
}
