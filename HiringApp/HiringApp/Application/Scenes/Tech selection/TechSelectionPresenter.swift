//
//  TechSelectionPresenter.swift
//  HiringApp
//
//  Created by Alejandro Garcia on 19/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class TechSelectionPresenter {

    //MARK: - Stored properties
    fileprivate let router: TechSelectionRouterProtocol
    fileprivate let interactor: TechSelectionInteractorProtocol
    fileprivate unowned let view: TechSelectionUserInterfaceProtocol

    var state: LoadingState<TechSelectionViewModel> = .loading {
        didSet {
            switch state {
            case .loaded(let viewModel):
                self.view.configureFor(viewModel: viewModel)

            default:
                break
            }
        }
    }

    var viewModel: TechSelectionViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                state = .error(AppError.unknown)
                return
            }

            state = .loaded(viewModel: viewModel)
        }
    }

    //MARK: - Initializer
    init(router: TechSelectionRouterProtocol, interactor: TechSelectionInteractorProtocol, view: TechSelectionUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension TechSelectionPresenter: TechSelectionPresenterProtocol {

    func viewDidLoad() {
        let task = interactor.retrieveData().upon(.main) { result in
            switch result {
            case .failure(let error):
                self.state = .error(error)
            case .success(let models):
                let technologyViewModels = models.map({ (model) -> TechnologyViewModel in
                    return TechnologyViewModel(id: model.id, title: model.title, imageURL: model.imageURL, testAvailable: model.testAvailable)
                })

                let viewModel = TechSelectionViewModel(title: "¿Cuál es tu tecnología?", techs: technologyViewModels)

                self.state = .loaded(viewModel: viewModel)
            }
        }
    }
}
