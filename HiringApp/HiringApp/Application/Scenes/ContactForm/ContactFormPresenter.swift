//
//  ContactFormPresenter.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import BSWFoundation

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
    
    //MARK: - Private API
    fileprivate func sendContactFormData(candidate: ContactFormViewModel) {
        interactor.sendContactFormData(candidate: candidate).upon(.main) { result in
            switch result {
            case .failure(let error):
                self.state = .error(error)
                showAlert(baseView: self.view as! UIViewController, title: "Error", message: "Error occured, please try again.")
            case .success():
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
        guard let unwrappedViewModel = viewModel, self.viewModel?.validate() == true else {
            return
        }
        
        view.showActivityIndicator()
        self.sendContactFormData(candidate: unwrappedViewModel)
    }
    
    func textFieldDidBeginEditing(field: InputTextType) {
        self.view.changeTextColorToCorrectInput(field: field)
    }
    
    func textFieldDidEndEditing(withText text: String, forField field: InputTextType) {
        guard var viewModel = self.viewModel else {
            return
        }
        
        defer {
            self.viewModel = viewModel
        }
        
        switch field {
        case .name:
            viewModel.name = text
            if !viewModel.nameIsValid() {
                self.view.changeTextColorToWrongInput(field: field)
            } else {
                self.view.changeTextColorToCorrectInput(field: field)
            }

        case .surname:
            viewModel.lastname = text
            if !viewModel.lastnameIsValid(){
                self.view.changeTextColorToWrongInput(field: field)
            } else {
                self.view.changeTextColorToCorrectInput(field: field)
            }
            
        case .linkedin:
            viewModel.linkedin = text
            if !viewModel.linkedInIsValid() {
                self.view.changeTextColorToWrongInput(field: field)
            } else {
                self.view.changeTextColorToCorrectInput(field: field)
            }
            
        case .address:
            viewModel.email = text
            if !viewModel.emailIsValid() {
                self.view.changeTextColorToWrongInput(field: field)
            } else {
                self.view.changeTextColorToCorrectInput(field: field)
            }
            
        case .phoneNumber:
            viewModel.phone = text
            if !viewModel.phoneIsValid() {
                self.view.changeTextColorToWrongInput(field: field)
            } else {
                self.view.changeTextColorToCorrectInput(field: field)
            }
        }
        
        if viewModel.validate() {
            self.view.setButtonState(enabled: true)
        }
    }
}
