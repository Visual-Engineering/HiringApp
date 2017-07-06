//
//  ContactFormSnapshoTestCase.swift
//  
//
//  Created by Alba Luján on 28/6/17.
//
//

import XCTest
@testable import HiringApp
@testable import HiringAppCore
import Deferred

private class ViewControllerFake: ContactFormUserInterfaceProtocol {
    
    var viewModel: ContactFormViewModel = ContactFormViewModel.fakeValid
    var viewModelInvalid: ContactFormViewModel = ContactFormViewModel.fakeInValid
    
    func setTextViewColor(forField field: InputTextType, withState state: TextViewInputState) {}
    func setButtonState(enabled: Bool) {}
    func showActivityIndicator() {}
    func hideActivityIndicator() {}
    func showErrorAlert() {}
}

private class InteractorFake: ContactFormInteractorProtocol {
    
    var isCalled: Bool = false
    
    func sendContactFormData(candidate: ContactFormViewModel) -> Task<()> {
        isCalled = true
        return Task(success: ())
    }
}

private class RouterDummy: ContactFormRouterProtocol {
    func navigateToNextScene(){}
}

private class RouterFake: ContactFormRouterProtocol {
    
    var isCalled = false
    
    func navigateToNextScene() {
        isCalled = true
    }
}

private class RepositoryFake: ContactFormRepositoryProtocol {
    
    var isCalled = false
    
    func sendContactFormData(candidate: CandidateModel) -> Task<()> {
        isCalled = true
        return Task(success: ())
    }
}

class ContactFormSnapshoTestCase: SnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
//    func testContactForm() {
//        guard let contactvc = ContactFormBuilder.build() else {
//            XCTAssert(false)
//            return
//        }
//        let nav = UINavigationController(rootViewController: contactvc)
//        debugViewController(nav)
//    }
    
    func testContactFormViewModelValidate() {
        
        //Given
        let fakeModelValid = ContactFormViewModel.fakeValid
        let fakeModelInValid = ContactFormViewModel.fakeInValid
    
        //When
        let boolValid = fakeModelValid.validate()
        let boolInValid = fakeModelInValid.validate()
        
        //Then
        if !boolValid {
            XCTAssert(false)
        }
        
        if boolInValid {
            XCTAssert(false)
        }
    }
    
    func testContactFormPresenterViewModel() {
        
        // Given
        let viewController = ViewControllerFake()
        let router = RouterDummy()
        let interactor = InteractorFake()
        let presenter = ContactFormPresenter(router: router, interactor: interactor, view: viewController)
        
        //When
        presenter.viewDidLoad()
        
        presenter.textFieldDidEndEditing(withText: viewController.viewModel.name, forField: .name)
        presenter.textFieldDidEndEditing(withText: viewController.viewModel.lastname, forField: .surname)
        presenter.textFieldDidEndEditing(withText: viewController.viewModel.linkedin, forField: .linkedin)
        presenter.textFieldDidEndEditing(withText: viewController.viewModel.email, forField: .address)
        presenter.textFieldDidEndEditing(withText: viewController.viewModel.phone, forField: .phoneNumber)
        
        //Then
        guard let viewModel = presenter.viewModel else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(viewModel == viewController.viewModel)
        
    }
    
    func testContactFormPresenterSendData() {
        
        //Case 1: Interactor should be called
        
        // Given
        let viewController = ViewControllerFake()
        let router = RouterDummy()
        let interactor = InteractorFake()
        let presenter = ContactFormPresenter(router: router, interactor: interactor, view: viewController)
        presenter.viewModel = viewController.viewModel
        
        //When
        presenter.tappedSendButton()
        
        //Wait a bit for the interactor to return a value
        
        //Set a timeout of 10 miliseconds, to ensure interactor is called
        let expectation = self.expectation(description: "Wait for some time")
        DispatchQueue.any().asyncAfter(deadline: .now() + .milliseconds(10)) {
            // We waited long enough for the interactor to be called
            // we will fulfill the expectation, to tell waitForExpectations to keep running the test
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssert(interactor.isCalled)
    }
    
    func testContactFormPresenterDontSendData() {
        
        //Case 2: Interactor should not be called
        
        // Given
        let viewController = ViewControllerFake()
        let router = RouterDummy()
        let interactor = InteractorFake()
        let presenter = ContactFormPresenter(router: router, interactor: interactor, view: viewController)
        presenter.viewModel = viewController.viewModelInvalid
        
        //When
        presenter.tappedSendButton()
        
        //Wait a bit for the interactor to return a value
        
        //Set a timeout of 10 miliseconds, to ensure interactor is called
        let expectation = self.expectation(description: "Wait for some time")
        DispatchQueue.any().asyncAfter(deadline: .now() + .milliseconds(10)) {
            // We waited long enough for the interactor to be called
            // we will fulfill the expectation, to tell waitForExpectations to keep running the test
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssert(!interactor.isCalled)
    }
    
    func testPresenterCallsRouter() {
        
        // Given
        let viewController = ViewControllerFake()
        let router = RouterFake()
        let interactor = InteractorFake()
        let presenter = ContactFormPresenter(router: router, interactor: interactor, view: viewController)
        presenter.viewModel = viewController.viewModel
        
        // Then
        presenter.tappedSendButton()
        
        let expectation = self.expectation(description: "Wait for some time")
        DispatchQueue.any().asyncAfter(deadline: .now() + .milliseconds(10)) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        // Then
        XCTAssert(router.isCalled)
    }
    
    func testContactFormInteractor() {
        
        let candidate = ContactFormViewModel(name: "juan", lastname: "palomo", linkedin: "", phone: "34234", email: "palomo@palomo.com")
        
        // Given
        let repository = RepositoryFake()
        let interactor = ContactFormInteractor(repository: repository)
        
        // When
        _ = interactor.sendContactFormData(candidate: candidate)
        
        
        // Then
        let repo = interactor.repository as? RepositoryFake
        XCTAssertNotNil(repo)
        XCTAssert(repo! === repository)
        XCTAssert(repository.isCalled)
    }
}

