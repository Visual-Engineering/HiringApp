//
//  AppRouter.swift
//  HiringApp
//
//  Created by Alejandro Garcia on 14/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

class AppRouter {

    //MARK: - Stored properties
    fileprivate let window: UIWindow
    fileprivate let rootViewController = AppRootViewController()

    //MARK: - Initializer
    init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
    }

    //MARK: - Public API
    func startApplication() {
        let builder: WalkthroughBuilder = WalkthroughBuilder()
        let viewController: UIViewController = builder.build()
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController.transitionToRootViewController(navigationController)
    }
}
