//
//  TechnologiesBuilder.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred

protocol TechnologiesPresenterProtocol {
    func viewDidLoad()
}

protocol TechnologiesInteractorProtocol {
    @discardableResult func retrieveData() -> Task<TechnologiesModel>
}

protocol TechnologiesUserInterfaceProtocol: class {
    func configureFor(viewModel: TechnologiesViewModel)
}

protocol TechnologiesRouterProtocol {
    func navigateToNextScene()
}

class TechnologiesBuilder {

    //MARK: - Configuration
    static func build() -> TechnologiesViewController {
        let viewController = TechnologiesViewController()
        let router = TechnologiesRouter(view: viewController)
        let interactor = TechnologiesInteractor()
        let presenter = TechnologiesPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
