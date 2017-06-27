//
//  WalkthroughPresenter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class WalkthroughPresenter {

    //MARK: - Stored properties
    fileprivate let router: WalkthroughRouterProtocol
    fileprivate let interactor: WalkthroughInteractorProtocol
    fileprivate unowned let view: WalkthroughUserInterfaceProtocol

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
    init(router: WalkthroughRouterProtocol, interactor: WalkthroughInteractorProtocol, view: WalkthroughUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension WalkthroughPresenter: WalkthroughPresenterProtocol {

    func viewDidLoad() {
        //        let task = interactor.retrieveData().upon(.main) { result in
        //            switch result {
        //            case .failure(let error):
        //                self.state = .error(error)
        //            case .success(let model):
        //                let vm = WalkthroughViewModel(..)
        //                self.state = .loaded(viewModel: vm)
        //            }
        //        }
    }
}
