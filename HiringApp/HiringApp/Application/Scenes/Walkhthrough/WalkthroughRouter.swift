//
//  WalkthroughRouter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit

class WalkthroughRouter {

    // MARK: - Stored properties
    unowned let view: WalkthroughViewController
    unowned let appRouter: AppRouterProtocol

    // MARK: Initializer
    init(view: WalkthroughViewController, appRouter: AppRouterProtocol) {
        self.view = view
        self.appRouter = appRouter
    }
}

extension WalkthroughRouter: WalkthroughRouterProtocol {

    func showModalMap() {
        let mapViewController = WalkthroughMapViewController()
        mapViewController.delegate = view
        let navigationController = UINavigationController(rootViewController: mapViewController)
        view.present(navigationController, animated: true)
    }
    
    func navigateToKnowMoreScene() {
        let controller = AboutUsBuilder.build()
        
        let navigation = UINavigationController(rootViewController: controller)
        view.present(navigation, animated: true)
    }
    
    func navigateToWorkWithUsScene() {
        appRouter.navigateTechnologyList()
    }
}
