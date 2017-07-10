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

    // MARK: - Stored properties
    let router: WalkthroughRouterProtocol
    fileprivate unowned let view: WalkthroughUserInterfaceProtocol

    // MARK: - Initializer
    init(router: WalkthroughRouterProtocol, view: WalkthroughUserInterfaceProtocol) {
        self.router = router
        self.view = view
    }
}

extension WalkthroughPresenter: WalkthroughPresenterProtocol {

    func viewDidLoad() {

    }
    
    func didClickOnMap() {
        router.showModalMap()
    }
    
    func didClickOnKnowMoreFromUs() {
        AnalyticsManager.shared.logEventWithFirebase(name: "selected_more_about_us", parameters: nil)
        router.navigateToKnowMoreScene()
    }
    
    func didClickOnWorkWithUs() {
        AnalyticsManager.shared.logEventWithFirebase(name: "selected_work_with_us", parameters: nil)
        router.navigateToWorkWithUsScene()
    }
}
