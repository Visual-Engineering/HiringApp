//
//  ContactFormBuilder.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred

protocol ContactFormPresenterProtocol {
    func viewDidLoad()
    func tappedSendButton()
    func textFieldDidBeginEditing(textField: UITextField)
    func textFieldDidEndEditing(textField: UITextField, withText: String, forField: InputTextType)
}

protocol ContactFormInteractorProtocol {
    func sendContactFormData(candidate: ContactFormViewModel) -> Task<()>
}

protocol ContactFormUserInterfaceProtocol: class {
    func changeTextColorForTextField(textField: UITextField, color: UIColor)
    func setButtonState(enabled: Bool)
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol ContactFormRouterProtocol {
    func navigateToNextScene()
}

class ContactFormBuilder {

    //MARK: - Configuration
    static func build() -> ContactFormViewController? {
        let viewController = ContactFormViewController()
        let router = ContactFormRouter(view: viewController)
        guard let interactor = ContactFormInteractor() else { return nil }
        
        let presenter = ContactFormPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
