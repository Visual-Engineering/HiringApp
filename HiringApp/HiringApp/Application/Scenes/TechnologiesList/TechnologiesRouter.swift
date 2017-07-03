//
//  TechnologiesRouter.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class TechnologiesRouter {

    //MARK: - Stored properties
    unowned let view: TechnologiesViewController

    //MARK: Initializer
    init(view: TechnologiesViewController) {
        self.view = view
    }
}

extension TechnologiesRouter: TechnologiesRouterProtocol {

    func navigateToNextScene() {

    }
}
