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
    var presenter: WalkthroughPresenterProtocol!
    let walkthroughViewController = BWWalkthroughViewController()
    
    @IBOutlet weak var pageControlWalkthrough: UIPageControl!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        navigationController?.navigationBar.isHidden = true
        edgesForExtendedLayout = []
        
        view.addSubviewWithAutolayout(walkthroughViewController.view)
        walkthroughViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        walkthroughViewController.view.fillSuperview()
    }
}

extension WalkthroughViewController: WalkthroughUserInterfaceProtocol {
    
}


