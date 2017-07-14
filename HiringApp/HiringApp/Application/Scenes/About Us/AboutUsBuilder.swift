//
//  AboutUsBuilder.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 13/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

protocol AboutUsPresenterProtocol {
    func viewDidLoad()
}

protocol AboutUsUserInterfaceProtocol: class {

}

protocol AboutUsRouterProtocol {
    func navigateToNextScene()
}

class AboutUsBuilder {

    // MARK: - Configuration
    static func build() -> AboutUsViewController {
        let viewController = AboutUsViewController()
        let router = AboutUsRouter(view: viewController)
        let presenter = AboutUsPresenter(router: router, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
