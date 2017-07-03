//
//  WalkthroughBuilder.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

protocol WalkthroughPresenterProtocol {
    func viewDidLoad()
}

protocol WalkthroughRouterProtocol {
    func navigateToNextScene()
}

class WalkthroughBuilder {

    //MARK: - Configuration
    static func build() -> WalkthroughViewController {
        let viewController = WalkthroughViewController()
        let router = WalkthroughRouter(view: viewController)
        let presenter = WalkthroughPresenter(router: router, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
