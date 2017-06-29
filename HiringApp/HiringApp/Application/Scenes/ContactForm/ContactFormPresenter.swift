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
    
    func tappedSendButton() {
//        let task = interactor.sendContactFormData(data: Data).upon(.main) { result in
//            switch result {
//            case .failure(let error):
//                self.state = .error(error)
//                //TODO: Show some alert that sending contact data failed?
//            case .success(): break
//                //TODO: Navigate back to some screen (?)
//            }
//        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "Type here..." {
            self.view.emptyTextInTextField(textField: textField)
        }
        self.view.changeTextColorForTextField(textField: textField, color: UIColor.darkGray)
    }
    
    func textFieldDidEndEditing(textField: UITextField, withText text: String, forField field: InputTextType){
        if text.isEmpty {
            self.view.restartTextFieldToDefault(textField: textField)
        }
        print("I am in the textFieldDidEndEditing")
    }
}
