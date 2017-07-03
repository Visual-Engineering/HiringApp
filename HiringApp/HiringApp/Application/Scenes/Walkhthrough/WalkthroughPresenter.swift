//
//  WalkthroughPresenter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import BWWalkthrough

class WalkthroughPresenter {

    //MARK: - Stored properties
    let router: WalkthroughRouter
    fileprivate unowned let view: WalkthroughViewController

    //MARK: - Initializer
    init(router: WalkthroughRouter, view: WalkthroughViewController) {
        self.router = router
        self.view = view
    }
}

extension WalkthroughPresenter: WalkthroughPresenterProtocol {

    func viewDidLoad() {
        
    }
}
