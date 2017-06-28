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
            let alert = Thing().foo()
            rootViewController.present(alert, animated: true, completion: nil)
            return
        }
        
//        guard let viewController = controller else {
//            let alert = UIAlertController(title: "Error", message: "Technologies view controller couldn't be initialized", preferredStyle: .alert)
//            let action: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(action)
//            rootViewController.present(alert, animated: true, completion: nil)
//            return
//        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController.transitionToRootViewController(navigationController)
    }
}

class Thing {
    func foo() -> UIViewController {
        let alert = UIAlertController(title: "Error", message: "Technologies view controller couldn't be initialized", preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
}
