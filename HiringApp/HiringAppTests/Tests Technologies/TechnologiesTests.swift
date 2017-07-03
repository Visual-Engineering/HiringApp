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

class PresenterFake: TechnologiesPresenterProtocol {
    let view: TechnologiesUserInterfaceProtocol
    
    init(view: TechnologiesUserInterfaceProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        let viewModel = TechnologiesViewModel.fake
        self.view.configureFor(viewModel: viewModel)
    }
}

class BuilderFake {
    
    static func build() -> TechnologiesViewController {
        let viewController = TechnologiesViewController()
        let presenter = PresenterFake(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
}

class RepositoryFake: TechsRepositoryProtocol {
    
    var isCalled = false
    
    func retrieveAPITechnologies() -> Task<[TechnologyModel]> {
        isCalled = true
        return Task(success: [TechnologyModel].fake)
    }
    
    func retrieveDBTechnologies() -> Task<[TechnologyModel]> {
        return Task(success: [TechnologyModel].fake)
    }
}

class InteractorFake: TechnologiesInteractorProtocol {
    func retrieveData() -> Task<[TechnologyModel]> {
        return Task(success: [TechnologyModel].fake)
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
        let technologiesVC = BuilderFake.build()
        verifyViewController(technologiesVC)
    }
    
    func testTechnologiesPresenter() {
        
        let view = ViewControllerMock(withExpectedData: TechnologiesViewModel.fake)
        
        // Given
        let presenter = TechnologiesPresenter(
            router: RouterDummy(),
            interactor: InteractorFake(),
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
    
    func testTechnologiesInteractor() {
        
        let repository = RepositoryFake()
        
        // Given
        guard let interactor = TechnologiesInteractor(repository: repository) else {
            XCTAssert(false)
            return
        }
        
        // When
        let data = interactor.retrieveData()
        
        let exp = expectation(description: "wait for retrieveData() to complete")
        
        // Then
        let repo = interactor.repository as? RepositoryFake
        XCTAssertNotNil(repo)
        XCTAssert(repo! === repository)
        XCTAssert(repository.isCalled)
        
        data.upon(.main) { (result) in
            switch result {
            case .failure(_):
                XCTAssert(false)
            case .success(let models):
                XCTAssert(models == [TechnologyModel].fake)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
