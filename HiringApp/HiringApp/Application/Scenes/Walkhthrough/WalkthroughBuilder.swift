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
    func didClickOnMap()
    func didClickOnKnowMoreFromUs()
    func didClickOnWorkWithUs()
}

protocol WalkthroughUserInterfaceProtocol: class {}

protocol WalkthroughRouterProtocol {
    func navigateToNextScene()
    func showModalMap()
    func navigateToKnowMoreScene()
    func navigateToWorkWithUsScene()
}

class WalkthroughBuilder {
    
    static let walkthroughViewController: WalkthroughViewController = {
        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        guard let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "container") as? WalkthroughViewController else {
            fatalError()
        }
        return walkthroughViewController
    }()

    // MARK: - Configuration
    static func build(appRouter: AppRouterProtocol) -> WalkthroughViewController {
        let viewController = walkthroughViewController
        let router = WalkthroughRouter(view: viewController, appRouter: appRouter)
        let presenter = WalkthroughPresenter(router: router, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
