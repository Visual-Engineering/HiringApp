//
//  AboutUsPresenter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 13/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class AboutUsPresenter {

    //MARK: - Stored properties
    fileprivate let router: AboutUsRouterProtocol
    fileprivate let interactor: AboutUsInteractorProtocol
    fileprivate unowned let view: AboutUsUserInterfaceProtocol

    var state: LoadingState<AboutUsViewModel> = .loading

    var viewModel: AboutUsViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                state = .error(AppError.unknown)
                return
            }

            state = .loaded(viewModel: viewModel)
        }
    }

    //MARK: - Initializer
    init(router: AboutUsRouterProtocol, interactor: AboutUsInteractorProtocol, view: AboutUsUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension AboutUsPresenter: AboutUsPresenterProtocol {

    func viewDidLoad() {
        //        let task = interactor.retrieveData().upon(.main) { result in
        //            switch result {
        //            case .failure(let error):
        //                self.state = .error(error)
        //            case .success(let model):
        //                let vm = AboutUsViewModel(..)
        //                self.state = .loaded(viewModel: vm)
        //            }
        //        }
    }
}
