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
        let controller: UIViewController? = TechnologiesBuilder.build()
        
        guard let viewController = controller else {
            let alert = createAlertController()
            rootViewController.present(alert, animated: true, completion: nil)
            return
        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController.transitionToRootViewController(navigationController)
    }
    
    func createAlertController() -> UIViewController {
        let alert = UIAlertController(title: R.string.localizable.error(), message: R.string.localizable.error_message(), preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
}
