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
        layout()
        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        navigationController?.navigationBar.isHidden = true
        edgesForExtendedLayout = []
        
        guard let walkVC = walkthroughViewController else { return }
        walkVC.delegate = self as BWWalkthroughViewControllerDelegate
        view.addSubviewWithAutolayout(walkVC.view)
        walkVC.view.translatesAutoresizingMaskIntoConstraints = false
        walkVC.view.fillSuperview()
    }
}

extension WalkthroughViewController: WalkthroughUserInterfaceProtocol {
    
}

extension WalkthroughViewController: BWWalkthroughViewControllerDelegate {
    @objc func walkthroughPageDidChange(_ pageNumber:Int){
        let viewControllers = presenter.viewControllers
        for viewController in viewControllers {
            viewController.view.transform = CGAffineTransform.identity
        }
    }

}


