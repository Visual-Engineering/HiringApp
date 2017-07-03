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
        guard let walkVC = walkthroughViewController as? WalkthroughContainerViewController else { return nil }
        return walkVC
    }()
    
    @IBOutlet weak var pageControlWalkthrough: UIPageControl!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        presenter.viewDidLoad()
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
}
