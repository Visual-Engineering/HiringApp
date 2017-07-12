//
//  TopicsSelectionBuilder.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
//import Deferred

protocol TopicsSelectionPresenterProtocol {
    func viewDidLoad()
}

protocol TopicsSelectionInteractorProtocol {
    //    func retrieveData() -> Task<TopicsSelectionViewModel>
}

protocol TopicsSelectionUserInterfaceProtocol: class {

}

protocol TopicsSelectionRouterProtocol {
    func navigateToNextScene()
}

class TopicsSelectionBuilder {

    //MARK: - Configuration
    static func build() -> TopicsSelectionViewController {
        let viewController = TopicsSelectionViewController()
        let router = TopicsSelectionRouter(view: viewController)
        let interactor = TopicsSelectionInteractor()
        let presenter = TopicsSelectionPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
