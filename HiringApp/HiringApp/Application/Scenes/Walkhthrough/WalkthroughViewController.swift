//
//  WalkthroughViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

protocol WalkthoughViewControllerDelegate: class {
    func didClickOnMap()
    func didClickOnWorkWithUs()
    func didClickOnKnowMoreFromUs()
}

class WalkthroughViewController: BWWalkthroughViewController {

    // MARK: - Stored properties
    var presenter: WalkthroughPresenterProtocol!
    
    @IBOutlet weak private var pageControlWalkthrough: UIPageControl!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configurePages()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.brandBlueColor()
        navigationController?.navigationBar.isHidden = true
        edgesForExtendedLayout = []        
    }
    
    private func configurePages() {
        let pageOneViewController = WalkthroughPageOneViewController()
        let pageTwoViewController = WalkthroughPageTwoViewController()
        
        let pageThreeViewController = WalkthroughPageThreeViewController()
        pageThreeViewController.delegate = self
        
        let pageFourViewController = WalkthroughPageFourViewController()
        pageFourViewController.delegate = self
        
        pageControl?.numberOfPages = 4
        add(viewController: pageOneViewController)
        add(viewController: pageTwoViewController)
        add(viewController: pageThreeViewController)
        add(viewController: pageFourViewController)
    }
}

extension WalkthroughViewController : WalkthroughUserInterfaceProtocol {
    
}

extension WalkthroughViewController: WalkthoughViewControllerDelegate {
    func didClickOnMap() {
        presenter.didClickOnMap()
    }
    
    func didClickOnWorkWithUs() {
        presenter.didClickOnWorkWithUs()
    }
    
    func didClickOnKnowMoreFromUs() {
        presenter.didClickOnKnowMoreFromUs()
    }
}
