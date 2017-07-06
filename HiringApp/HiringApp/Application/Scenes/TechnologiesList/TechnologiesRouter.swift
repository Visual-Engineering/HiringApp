//
//  TechnologiesRouter.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class TechnologiesRouter {

    // MARK: - Stored properties
    unowned let view: TechnologiesViewController

    // MARK: Initializer
    init(view: TechnologiesViewController) {
        self.view = view
    }
}

extension TechnologiesRouter: TechnologiesRouterProtocol {
    
    func navigateToNextScene(selectedTechnology: TechnologyViewModel) {
        if !selectedTechnology.testAvailable {
            guard let viewController = ContactFormBuilder.build() else { return }
            viewController.title = selectedTechnology.title
            view.navigationController?.pushViewController(viewController, animated: true)
        } else {
            // TODO: Navigate when test available
        }

    }
}
