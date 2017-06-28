//
//  ContactFormPresenter.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class ContactFormPresenter {

    //MARK: - Stored properties
    fileprivate let router: ContactFormRouterProtocol
    fileprivate let interactor: ContactFormInteractorProtocol
    fileprivate unowned let view: ContactFormUserInterfaceProtocol

    var state: LoadingState<ContactFormViewModel> = .loading

    var viewModel: ContactFormViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                state = .error(AppError.unknown)
                return
            }

            state = .loaded(viewModel: viewModel)
        }
    }

    //MARK: - Initializer
    init(router: ContactFormRouterProtocol, interactor: ContactFormInteractorProtocol, view: ContactFormUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension ContactFormPresenter: ContactFormPresenterProtocol {

    func viewDidLoad() {
        //        let task = interactor.retrieveData().upon(.main) { result in
        //            switch result {
        //            case .failure(let error):
        //                self.state = .error(error)
        //            case .success(let model):
        //                let vm = ContactFormViewModel(..)
        //                self.state = .loaded(viewModel: vm)
        //            }
        //        }
    }
}
