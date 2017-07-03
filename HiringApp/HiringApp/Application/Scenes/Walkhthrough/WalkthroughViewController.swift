//
//  WalkthroughViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

class WalkthroughViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: WalkthroughPresenter!
    var walkthroughViewController: WalkthroughContainerViewController? = {
        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "container")
        return walkthroughViewController as? WalkthroughContainerViewController
    }()
    
    var viewControllers = [BWWalkthroughPageViewController]()
    
    @IBOutlet weak var pageControlWalkthrough: UIPageControl!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        configureWalkthoughContainer()
    }

    //MARK: - Private API
    private func layout() {
        guard let walkVC = walkthroughViewController else { return }
        
        view.addSubviewWithAutolayout(walkVC.view)
        walkVC.view.translatesAutoresizingMaskIntoConstraints = false
        walkVC.view.fillSuperview()
    }
    
    private func setup() {
        navigationController?.navigationBar.isHidden = true
        edgesForExtendedLayout = []
    }
    
    func configureWalkthoughContainer() {
        guard let walkViewController = walkthroughViewController else { return }
        
        let pageOneViewController = WalkthroughPageOneViewController()
        let pageTwoViewController = WalkthroughPageTwoViewController()
        
        let pageThreeViewController = WalkthroughPageThreeViewController()
        pageThreeViewController.presenter = presenter
        
        let pageFourViewController = WalkthroughPageFourViewController()
        pageFourViewController.presenter = presenter
        
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
