//
//  ContactFormRouter.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class ContactFormRouter {

    //MARK: - Stored properties
    unowned let view: ContactFormViewController

    //MARK: Initializer
    init(view: ContactFormViewController) {
        self.view = view
    }
}

extension ContactFormRouter: ContactFormRouterProtocol {

    func navigateToNextScene() {
        let viewController = ContactFormSentViewController()
        view.present(viewController, animated: true, completion: nil)
    }
}
