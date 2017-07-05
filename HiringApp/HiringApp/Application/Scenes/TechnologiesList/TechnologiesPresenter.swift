//
//  TechnologiesPresenter.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred

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
        
        interactor.retrieveData()
            .map(upon: .main) { $0.map({ (model) -> TechnologyViewModel in
                return TechnologyViewModel(id: model.id,
                                    title: model.title,
                                    imageURL: model.imageURL,
                                    testAvailable: model.testAvailable,
                                    submittedTest: model.submittedTest) })
            }
        
            .upon(.main) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .failure(let error):
                    strongSelf.state = .error(error)
                case .success(let vm):
                    let viewModel = TechnologiesViewModel(title: "¿Cuál es tu tecnología?", techs: vm)
                    strongSelf.viewModel = viewModel
                    strongSelf.view.configureFor(viewModel: viewModel)
                }
        }
    }
}
