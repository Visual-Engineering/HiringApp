//
//  TechSelectionBuilder.swift
//  HiringApp
//
//  Created by Alejandro Garcia on 19/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred
import HiringAppCore

protocol TechSelectionPresenterProtocol {
    func viewDidLoad()
}

protocol TechSelectionInteractorProtocol {
    func retrieveData() -> Task<[TechnologyModel]>
}

protocol TechSelectionUserInterfaceProtocol: class {
    func configureFor(viewModel: TechSelectionViewModel)
}

protocol TechSelectionRouterProtocol {
    func navigateToNextScene()
}

class TechSelectionBuilder {

    //MARK: - Configuration
    static func build() -> TechSelectionViewController {
        let viewController = TechSelectionViewController()
        let router = TechSelectionRouter(view: viewController)
        let interactor = TechSelectionInteractor()
        let presenter = TechSelectionPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
