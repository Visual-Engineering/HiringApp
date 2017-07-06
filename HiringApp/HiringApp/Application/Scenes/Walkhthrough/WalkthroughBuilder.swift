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
    
    let walkthroughViewController: WalkthroughViewController = {
        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "container")
        return walkthroughViewController as! WalkthroughViewController
    }()

    //MARK: - Configuration
    func build() -> WalkthroughViewController {
        let viewController = walkthroughViewController
        let router = WalkthroughRouter(view: viewController)
        let presenter = WalkthroughPresenter(router: router, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}