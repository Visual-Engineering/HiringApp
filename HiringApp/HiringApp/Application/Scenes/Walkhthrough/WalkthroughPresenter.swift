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
        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        

        let pageOneViewController = storyboard.instantiateViewController(withIdentifier: "page_1")
        let pageTwoViewController = storyboard.instantiateViewController(withIdentifier: "page_2")
        
        guard let pageThreeViewController = storyboard.instantiateViewController(withIdentifier: "page_3") as? WalkthroughPageThreeViewController else { return }
        pageThreeViewController.router = router
        
        guard let pageFourViewController = storyboard.instantiateViewController(withIdentifier: "page_4") as? WalkthroughPageFourViewController else { return }
        pageFourViewController.router = router
        
        walkViewController.pageControl?.numberOfPages = 4
        walkViewController.delegate = view
        walkViewController.add(viewController: pageOneViewController)
        walkViewController.add(viewController: pageTwoViewController)
        walkViewController.add(viewController: pageThreeViewController)
        walkViewController.add(viewController: pageFourViewController)
        
        viewControllers.append(pageOneViewController as! BWWalkthroughPageViewController)
        viewControllers.append(pageTwoViewController as! BWWalkthroughPageViewController)
        viewControllers.append(pageThreeViewController)
        viewControllers.append(pageFourViewController)
    }
}
