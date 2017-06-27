//
//  WalkthroughBuilder.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
//import Deferred

protocol WalkthroughPresenterProtocol {
    func viewDidLoad()
}

protocol WalkthroughInteractorProtocol {
    //    func retrieveData() -> Task<WalkthroughViewModel>
}

protocol WalkthroughUserInterfaceProtocol: class {

}

protocol WalkthroughRouterProtocol {
    func navigateToNextScene()
}

class WalkthroughBuilder {

    //MARK: - Configuration
    static func build() -> WalkthroughViewController {
        let viewController = WalkthroughViewController()
        let router = WalkthroughRouter(view: viewController)
        let interactor = WalkthroughInteractor()
        let presenter = WalkthroughPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
