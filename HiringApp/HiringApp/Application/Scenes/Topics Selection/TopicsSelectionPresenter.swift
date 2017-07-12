//
//  TopicsSelectionPresenter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class TopicsSelectionPresenter {

    //MARK: - Stored properties
    fileprivate let router: TopicsSelectionRouterProtocol
    fileprivate let interactor: TopicsSelectionInteractorProtocol
    fileprivate unowned let view: TopicsSelectionUserInterfaceProtocol

    var state: LoadingState<TopicsSelectionViewModel> = .loading

    var viewModel: TopicsSelectionViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                state = .error(AppError.unknown)
                return
            }

            state = .loaded(viewModel: viewModel)
        }
    }

    //MARK: - Initializer
    init(router: TopicsSelectionRouterProtocol, interactor: TopicsSelectionInteractorProtocol, view: TopicsSelectionUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension TopicsSelectionPresenter: TopicsSelectionPresenterProtocol {

    func viewDidLoad() {
        //        let task = interactor.retrieveData().upon(.main) { result in
        //            switch result {
        //            case .failure(let error):
        //                self.state = .error(error)
        //            case .success(let model):
        //                let vm = TopicsSelectionViewModel(..)
        //                self.state = .loaded(viewModel: vm)
        //            }
        //        }
    }
}
