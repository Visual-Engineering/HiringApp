//
//  WalkthroughPresenter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import BWWalkthrough

class WalkthroughPresenter {

    //MARK: - Stored properties
    fileprivate let router: WalkthroughRouter
    fileprivate unowned let view: WalkthroughViewController

    var viewControllers = [BWWalkthroughPageViewController]()

    //MARK: - Initializer
    init(router: WalkthroughRouter, view: WalkthroughViewController) {
        self.router = router
        self.view = view
    }
}

extension WalkthroughPresenter: WalkthroughPresenterProtocol {

    func viewDidLoad() {
        configureWalkthoughContainer()
    }
    
    func configureWalkthoughContainer() {
        guard let walkViewController = view.walkthroughViewController else { return }
        
        let pageOneViewController = WalkthroughPageOneViewController()
        let pageTwoViewController = WalkthroughPageTwoViewController()
        
        let pageThreeViewController = WalkthroughPageThreeViewController()
        pageThreeViewController.router = router
        
        let pageFourViewController = WalkthroughPageFourViewController()
        pageFourViewController.router = router
        
        walkViewController.pageControl?.numberOfPages = 4
        walkViewController.add(viewController: pageOneViewController)
        walkViewController.add(viewController: pageTwoViewController)
        walkViewController.add(viewController: pageThreeViewController)
        walkViewController.add(viewController: pageFourViewController)
        
        viewControllers.append(pageOneViewController)
        viewControllers.append(pageTwoViewController)
        viewControllers.append(pageThreeViewController)
        viewControllers.append(pageFourViewController)
    }
}
