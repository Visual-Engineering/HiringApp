//
//  HiringAppUITests.swift
//  HiringAppUITests
//
//  Created by Alejandro Garcia on 14/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest

class HiringAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMapViewExistsOnMapViewController() {
        //Given
        let app = XCUIApplication()
        
        app.scrollViews.children(matching: .other).element.swipeLeft()
        app.scrollViews.children(matching: .other).element.swipeLeft()
        
        let elementsQuery = app.scrollViews.otherElements
        let image = elementsQuery.children(matching: .image).element
        
        //When
        image.tap()
        
        //Then
        let map = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .map).element
        XCTAssert(map.exists == true)
    }
    
    func testIsDataSentByContactForm() {
        //Given
        let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.children(matching: .other).element.swipeLeft()
        scrollViewsQuery.children(matching: .other).element.swipeLeft()
        scrollViewsQuery.children(matching: .other).element.swipeLeft()
        
        let elementsQuery = scrollViewsQuery.otherElements
        
        elementsQuery.buttons["Work with us"].tap()
        app.buttons["Diseño"].tap()
        
        //When
        let nameTextField = app.textFields["nameTextField"]
        nameTextField.tap()
        nameTextField.typeText("Posible")
        
        let surnameTextField = app.textFields["surnameTextfield"]
        surnameTextField.tap()
        surnameTextField.typeText("Candidato")
        
        let linkedinTextField = app.textFields["linkedInTextField"]
        linkedinTextField.tap()
        linkedinTextField.typeText("http://linkedin.com/posiblecandidato")
        
        let emailTextField = app.textFields["addressTextField"]
        emailTextField.tap()
        emailTextField.typeText("sochoa@visual.com")
        
        let phoneTextfield = app.textFields["phoneTextField"]
        phoneTextfield.tap()
        phoneTextfield.typeText("968282541")
        
        //Force 'textFieldDidEndEditing', so phoneTextField is also validated. 
        emailTextField.tap()

        let buttonSendContactForm = app.buttons["buttonSendContactForm"]
        buttonSendContactForm.tap()
        
        sleep(3)
        
        let labelSentForm = app.staticTexts["labelContactFormSent"]
        
        //Then
        XCTAssert(labelSentForm.exists)
    }
    
}
