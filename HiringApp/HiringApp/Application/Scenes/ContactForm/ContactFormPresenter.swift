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
}

extension ContactFormPresenter: ContactFormPresenterProtocol {

    func viewDidLoad() {
        self.viewModel = ContactFormViewModel()
    }
    
    func tappedSendButton() {
        guard let unwrappedViewModel = viewModel, self.viewModel?.validate() == true else {
            return
        }
        
        interactor.sendContactFormData(candidate: unwrappedViewModel).upon(.main) { result in
            switch result {
            case .failure(let error):
                self.state = .error(error)
                //TODO: Show some alert that sending contact data failed?
            case .success():
                self.router.navigateToNextScene()
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.view.changeTextColorForTextField(textField: textField, color: UIColor.darkGray)
    }
    
    func textFieldDidEndEditing(textField: UITextField, withText text: String, forField field: InputTextType) {
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
                //showAlert(baseView: self.view as! UIViewController, title: "Error", message: "Nombre no valido")
                self.view.changeTextColorForTextField(textField: textField, color: .red)
            } else {
                self.view.changeTextColorForTextField(textField: textField, color: .darkGray)
            }

        case .surname:
            viewModel.lastname = text
            if !viewModel.lastnameIsValid(){
                //showAlert(baseView: self.view as! UIViewController, title: "Error", message: "Apellidos no son validos")
                self.view.changeTextColorForTextField(textField: textField, color: .red)
            } else {
                self.view.changeTextColorForTextField(textField: textField, color: .darkGray)
            }
            
        case .linkedin:
            viewModel.linkedin = text
            if !viewModel.linkedInIsValid() {
                //showAlert(baseView: self.view as! UIViewController, title: "Error", message: "URL no valido")
                self.view.changeTextColorForTextField(textField: textField, color: .red)
            } else {
                self.view.changeTextColorForTextField(textField: textField, color: .darkGray)
            }
            
        case .address:
            viewModel.email = text
            if !viewModel.emailIsValid() {
                //showAlert(baseView: self.view as! UIViewController, title: "Error", message: "Email no valido")
                self.view.changeTextColorForTextField(textField: textField, color: .red)
            } else {
                self.view.changeTextColorForTextField(textField: textField, color: .darkGray)
            }
            
        case .phoneNumber:
            viewModel.phone = text
            if !viewModel.phoneIsValid() {
                //showAlert(baseView: self.view as! UIViewController, title: "Error", message: "Teléfono no valido")
                self.view.changeTextColorForTextField(textField: textField, color: .red)
            } else {
                self.view.changeTextColorForTextField(textField: textField, color: .darkGray)
            }
        }
        
        if viewModel.validate() {
            self.view.setButtonState(enabled: true)
        }
    }
    
    func presentAlert(title: String, message: String) {
        showAlert(baseView: self.view as! UIViewController, title: title, message: message)
    }
}
