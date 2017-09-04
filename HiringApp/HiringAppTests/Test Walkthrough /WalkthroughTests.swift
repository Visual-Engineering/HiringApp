//
//  WalkthroughTests.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 05/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
@testable import HiringApp

class WalkthroughTests: XCTestCase {
    
    private class RouterSpy: WalkthroughRouterProtocol {
        
        var isShowModalMapCalled = false
        var isNavigateToKnowMoreScene = false
        var isNavigateToWorkWithUsScene = false

        func navigateToNextScene() {}
        
        func showModalMap() {
            isShowModalMapCalled = true
        }
        
        func navigateToKnowMoreScene() {
            isNavigateToKnowMoreScene = true
        }
        
        func navigateToWorkWithUsScene() {
            isNavigateToWorkWithUsScene = true
        }
    }
    
    private class UserInterfaceDummy: WalkthroughUserInterfaceProtocol {

    }
    
    func testPresenterClickOnMapShouldCallRouter() {
        //Given
        let routerSpy = RouterSpy()
        let presenter = WalkthroughPresenter(router: routerSpy, view: UserInterfaceDummy())
        
        //When
        presenter.didClickOnMap()
        
        //Then
        XCTAssert(routerSpy.isShowModalMapCalled)
    }
    
    func testPresenterClickOnKnowMoreFromUs() {
        //Given
        let routerSpy = RouterSpy()
        let presenter = WalkthroughPresenter(router: routerSpy, view: UserInterfaceDummy())
        
        //When
        presenter.didClickOnKnowMoreFromUs()
        
        //Then
        XCTAssert(routerSpy.isNavigateToKnowMoreScene)
    }
    
    func testPresenterClickOnWorkWithUs() {
        //Given
        let routerSpy = RouterSpy()
        let presenter = WalkthroughPresenter(router: routerSpy, view: UserInterfaceDummy())
        
        //When
        presenter.didClickOnWorkWithUs()
        
        //Then
        XCTAssert(routerSpy.isNavigateToWorkWithUsScene)
    }
}
