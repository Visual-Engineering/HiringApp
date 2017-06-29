//
//  HiringAppTests.swift
//  HiringAppTests
//
//  Created by Alejandro Garcia on 14/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
@testable import HiringApp
@testable import HiringAppCore
import Deferred

class TechnologiesPresenterFake: TechnologiesPresenterProtocol {
    let view: TechnologiesUserInterfaceProtocol
    
    init(view: TechnologiesUserInterfaceProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        let viewModel = TechnologiesViewModel.fake
        self.view.configureFor(viewModel: viewModel)
    }
}

class TechnologiesBuilderFake {
    
    static func build() -> TechnologiesViewController {
        let viewController = TechnologiesViewController()
        let presenter = TechnologiesPresenterFake(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
}

class TechnologiesInteractorFake: TechnologiesInteractorProtocol {
    func retrieveData() -> Task<[TechnologyModel]> {
        return Task(success: [TechnologyModel].fakeHiringAppTest)
    }
}

class ViewControllerMock: TechnologiesUserInterfaceProtocol {
    
    var isCalled: Bool = false
    
    let expectedData: TechnologiesViewModel
    
    init(withExpectedData expectedData: TechnologiesViewModel) {
        self.expectedData = expectedData
    }
    
    func configureFor(viewModel: TechnologiesViewModel) {
        isCalled = (viewModel == expectedData)
    }
}

class RouterDummy: TechnologiesRouterProtocol {
    func navigateToNextScene() {}
}

class TechnologiesTests: SnapshotTestCase {
    
    func testSnapshotTechnologies() {
//        recordMode = true
        let technologiesVC = TechnologiesBuilderFake.build()
        verifyViewController(technologiesVC)
    }
    
    func testTechnologiesPresenter() {
        
        let view = ViewControllerMock(withExpectedData: TechnologiesViewModel.fake)
        
        // Given
        let presenter = TechnologiesPresenter(
            router: RouterDummy(),
            interactor: TechnologiesInteractorFake(),
            view: view
        )
        
        // When
        presenter.viewDidLoad()
        
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        // Then
        guard let techs = presenter.viewModel?.techs else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(techs == TechnologiesViewModel.fake.techs)
        
        XCTAssert(view.isCalled)
    }
    
}
