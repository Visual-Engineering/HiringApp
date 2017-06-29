//
//  ContactFormBuilder.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
//import Deferred

protocol ContactFormPresenterProtocol {
    func viewDidLoad()
}

protocol ContactFormInteractorProtocol {
    //    func retrieveData() -> Task<ContactFormViewModel>
}

protocol ContactFormUserInterfaceProtocol: class {

}

protocol ContactFormRouterProtocol {
    func navigateToNextScene()
}

class ContactFormBuilder {

    //MARK: - Configuration
    static func build() -> ContactFormViewController {
        let viewController = ContactFormViewController()
        let router = ContactFormRouter(view: viewController)
        let interactor = ContactFormInteractor()
        let presenter = ContactFormPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}