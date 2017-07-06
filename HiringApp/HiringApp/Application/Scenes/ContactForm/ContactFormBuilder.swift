//
//  ContactFormBuilder.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred
import HiringAppCore

protocol ContactFormPresenterProtocol {
    func viewDidLoad()
    func tappedSendButton()
    func textFieldDidBeginEditing(field: InputTextType)
    func textFieldDidEndEditing(withText: String, forField: InputTextType)
}

protocol ContactFormInteractorProtocol {
    func sendContactFormData(candidate: ContactFormViewModel) -> Task<()>
}

protocol ContactFormUserInterfaceProtocol: class {
    func setTextViewColor(forField field: InputTextType, withState state: TextViewInputState)
    func setButtonState(enabled: Bool)
    func showActivityIndicator()
    func hideActivityIndicator()
    func showErrorAlert()
}

protocol ContactFormRouterProtocol {
    func navigateToNextScene()
}

class ContactFormBuilder {

    // MARK: - Configuration
    static func build() -> ContactFormViewController? {
        let viewController = ContactFormViewController()
        let router = ContactFormRouter(view: viewController)
        let interactor = ContactFormInteractor(repository: ContactFormRepository())
        
        let presenter = ContactFormPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
