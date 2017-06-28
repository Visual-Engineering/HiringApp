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
    fileprivate let router: WalkthroughRouterProtocol
    fileprivate let interactor: WalkthroughInteractorProtocol
    fileprivate unowned let view: WalkthroughViewController

    var viewControllers = [BWWalkthroughPageViewController]()

    //MARK: - Initializer
    init(router: WalkthroughRouterProtocol, interactor: WalkthroughInteractorProtocol, view: WalkthroughViewController) {
        self.router = router
        self.interactor = interactor
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
        pageThreeViewController.presenter = self
        let pageFourViewController = storyboard.instantiateViewController(withIdentifier: "page_4")
        
        walkViewController.pageControl?.numberOfPages = 4
        walkViewController.add(viewController: pageOneViewController)
        walkViewController.add(viewController: pageTwoViewController)
        walkViewController.add(viewController: pageThreeViewController)
        walkViewController.add(viewController: pageFourViewController)
        
        viewControllers.append(pageOneViewController as! BWWalkthroughPageViewController)
        viewControllers.append(pageTwoViewController as! BWWalkthroughPageViewController)
        viewControllers.append(pageThreeViewController as BWWalkthroughPageViewController)
        viewControllers.append(pageFourViewController as! BWWalkthroughPageViewController)
    }
}

extension WalkthroughPresenter {
    
    func showModalMap() {
        let mapViewController = WalkthroughMapViewController()
        let navigationController = UINavigationController(rootViewController: mapViewController)
        view.present(navigationController, animated: true)
    }
    
}
