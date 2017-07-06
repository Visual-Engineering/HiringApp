//
//  TechnologiesBuilder.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred
import HiringAppCore

protocol TechnologiesPresenterProtocol {
    func viewDidLoad()
    func didClickOnTechnology(index: Int)
}

protocol TechnologiesInteractorProtocol {
    @discardableResult func retrieveData() -> Task<[TechnologyModel]>
}

protocol TechnologiesUserInterfaceProtocol: class {
    func configureFor(viewModel: TechnologiesViewModel)
}

protocol TechnologiesRouterProtocol {
    func navigateToNextScene(selectedTechnology: TechnologyViewModel)
}

class TechnologiesBuilder {

    //MARK: - Configuration
    static func build() -> TechnologiesViewController? {
        let viewController = TechnologiesViewController()
        let router = TechnologiesRouter(view: viewController)
        
        guard let interactor = TechnologiesInteractor() else {
            return nil
        }
        
        let presenter = TechnologiesPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
