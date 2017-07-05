//
//  WalkthroughViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

protocol PageControllerDelegate {
    func didClickOnMap()
}

class WalkthroughViewController: BWWalkthroughViewController {

    //MARK: - Stored properties
    var presenter: WalkthroughPresenter!
    
    @IBOutlet weak var pageControlWalkthrough: UIPageControl!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configureWalkthoughContainer()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.brandBlueColor()
        navigationController?.navigationBar.isHidden = true
        edgesForExtendedLayout = []
    }
    
    func configureWalkthoughContainer() {
        let pageOneViewController = WalkthroughPageOneViewController()
        let pageTwoViewController = WalkthroughPageTwoViewController()
        
        let pageThreeViewController = WalkthroughPageThreeViewController()
        pageThreeViewController.presenter = presenter
        
        let pageFourViewController = WalkthroughPageFourViewController()
        pageFourViewController.presenter = presenter
        
        pageControl?.numberOfPages = 4
        add(viewController: pageOneViewController)
        add(viewController: pageTwoViewController)
        add(viewController: pageThreeViewController)
        add(viewController: pageFourViewController)
    }
}

extension WalkthroughViewController: PageControllerDelegate {
    func didClickOnMap() {
        presenter.showModalMap()
    }
}
