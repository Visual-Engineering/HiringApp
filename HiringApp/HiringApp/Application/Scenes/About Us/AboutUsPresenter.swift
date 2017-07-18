//
//  AboutUsPresenter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 13/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class AboutUsPresenter {

    //MARK: - Stored properties
    fileprivate let router: AboutUsRouterProtocol
    fileprivate unowned let view: AboutUsUserInterfaceProtocol

    //MARK: - Initializer
    init(router: AboutUsRouterProtocol, view: AboutUsUserInterfaceProtocol) {
        self.router = router
        self.view = view
    }
}

extension AboutUsPresenter: AboutUsPresenterProtocol {

    func viewDidLoad() {
       
    }
}
