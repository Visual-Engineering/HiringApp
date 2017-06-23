//
//  TechnologiesPresenter.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class TechnologiesPresenter {

    //MARK: - Stored properties
    fileprivate let router: TechnologiesRouterProtocol
    fileprivate let interactor: TechnologiesInteractorProtocol
    fileprivate unowned let view: TechnologiesUserInterfaceProtocol

    var state: LoadingState<TechnologiesViewModel> = .loading

    var viewModel: TechnologiesViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                state = .error(AppError.unknown)
                return
            }

            state = .loaded(viewModel: viewModel)
        }
    }

    //MARK: - Initializer
    init(router: TechnologiesRouterProtocol, interactor: TechnologiesInteractorProtocol, view: TechnologiesUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension TechnologiesPresenter: TechnologiesPresenterProtocol {

    func viewDidLoad() {
        
        let technologiesListStrings = ["ios", "android", "backend"]
        guard let viewConf = view as? ViewModelConfigurable else { fatalError() }
        viewConf.configureFor(viewModel: <#T##ViewModelConfigurable.VM#>)
        
        //        let task = interactor.retrieveData().upon(.main) { result in
        //            switch result {
        //            case .failure(let error):
        //                self.state = .error(error)
        //            case .success(let model):
        //                let vm = TechnologiesViewModel(..)
        //                self.state = .loaded(viewModel: vm)
        //            }
        //        }
    }
}
