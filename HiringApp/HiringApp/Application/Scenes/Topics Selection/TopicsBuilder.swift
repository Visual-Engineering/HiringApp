//
//  TopicsBuilder.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
//import Deferred

protocol TopicsPresenterProtocol {
    func viewDidLoad()
}

protocol TopicsInteractorProtocol {
    //    func retrieveData() -> Task<TopicsViewModel>
}

protocol TopicsUserInterfaceProtocol: class {

}

protocol TopicsRouterProtocol {
    func navigateToNextScene()
}

class TopicsBuilder {

    //MARK: - Configuration
    static func build() -> TopicsViewController {
        let viewController = TopicsViewController()
        let router = TopicsRouter(view: viewController)
        let interactor = TopicsInteractor()
        let presenter = TopicsPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
