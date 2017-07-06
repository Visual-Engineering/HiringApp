//
//  ContactFormPresenter.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class ContactFormPresenter {

    // MARK: - Stored properties
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

    // MARK: - Initializer
    init(router: ContactFormRouterProtocol, interactor: ContactFormInteractorProtocol, view: ContactFormUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
    
    // MARK: - Private API
    fileprivate func sendContactFormData(candidate: ContactFormViewModel) {
        interactor.sendContactFormData(candidate: candidate).upon(.main) { result in
            switch result {
            case .failure(let error):
                self.state = .error(error)
                self.view.showErrorAlert()
            case .success:
                self.view.hideActivityIndicator()
                self.router.navigateToNextScene()
            }
        }
    }
}

extension ContactFormPresenter: ContactFormPresenterProtocol {

    func viewDidLoad() {
        self.viewModel = ContactFormViewModel()
    }
    
    func tappedSendButton() {
        guard let viewModel = viewModel, self.viewModel?.validate() == true else {
            return
        }
        
        view.showActivityIndicator()
        self.sendContactFormData(candidate: viewModel)
    }
    
    func textFieldDidBeginEditing(field: InputTextType) {
        self.view.setTextViewColor(forField: field, withState: .correct)
    }
    
    func textFieldDidEndEditing(withText text: String, forField field: InputTextType) {
        guard var viewModel = self.viewModel else {
            return
        }
        
        defer {
            self.viewModel = viewModel
        }
        
        func changeColorToField(valid: Bool) {
            self.view.setTextViewColor(forField: field, withState: valid ? .correct : .incorrect)
        }
        
        switch field {
        case .name:
            viewModel.name = text
            changeColorToField(valid: viewModel.nameIsValid())

        case .surname:
            viewModel.lastname = text
            changeColorToField(valid: viewModel.lastnameIsValid())
            
        case .linkedin:
            viewModel.linkedin = text
            changeColorToField(valid: viewModel.linkedInIsValid())
            
        case .address:
            viewModel.email = text
            changeColorToField(valid: viewModel.emailIsValid())
            
        case .phoneNumber:
            viewModel.phone = text
            changeColorToField(valid: viewModel.phoneIsValid())
        }
        
        if viewModel.validate() {
            self.view.setButtonState(enabled: true)
        }
    }
}
