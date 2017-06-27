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

    var state: LoadingState<WalkthroughViewModel> = .loading

    var viewModel: WalkthroughViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                state = .error(AppError.unknown)
                return
            }

            state = .loaded(viewModel: viewModel)
        }
    }

    //MARK: - Initializer
    init(router: WalkthroughRouterProtocol, interactor: WalkthroughInteractorProtocol, view: WalkthroughViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension WalkthroughPresenter: WalkthroughPresenterProtocol {

    func viewDidLoad() {
        self.view.walkthroughViewController.delegate = self
        //self.view.walkthroughViewController.scrollview.isPagingEnabled = true
        let pageOneViewController = WakthroughPageOneViewController()
        let pageTwoViewController = WakthroughPageTwoViewController()

        self.view.walkthroughViewController.add(viewController: pageOneViewController)
        self.view.walkthroughViewController.add(viewController: pageTwoViewController)

    }
}

extension WalkthroughPresenter: BWWalkthroughViewControllerDelegate {
    func walkthroughNextButtonPressed(){
        
    }
    
    func walkthroughPrevButtonPressed(){
        
    }
    
    func walkthroughPageDidChange(pageNumber:Int){
        
    }
}
