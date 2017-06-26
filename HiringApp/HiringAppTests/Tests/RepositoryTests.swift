//
//  RepositoryTests.swift
//  HiringApp
//
//  Created by Alba Luján on 26/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
@testable import HiringAppCore
import Deferred

class RepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRepositoryProvidersCacheEmpty() {
        
        // CASE 1 : cache is empty, call api provider
        //Given
        let exp = expectation(description: "Download techologies")
        let fakeCache = CacheProviderFake()
        fakeCache.isEmpty = true
        let apiSpy = APIProviderSpy()
        let dbProvider = DBProviderFake()
        let repository = Repository(apiProvider: apiSpy, cacheProvider: fakeCache, dbProvider: dbProvider)
        
        //When
        let task: Task<[TechnologyModel]> = repository.retrieveTechnologies()
        task.upon(.main) { (result) in
            switch result {
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTAssert(false)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        if apiSpy.isCalled {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
        
        if fakeCache.isSaved {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }

    func testRepositoryProvidersCacheFull() {
        
        // CASE 2 : cache is full, don't call api provider
        //Given
        let fakeCache = CacheProviderFake()
        fakeCache.isEmpty = false
        let apiSpy = APIProviderSpy()
        let dbProvider = DBProviderFake()
        let repository = Repository(apiProvider: apiSpy, cacheProvider: fakeCache, dbProvider: dbProvider)
        
        //When
        let _ = repository.retrieveTechnologies()
        
        //Then
        if apiSpy.isCalled {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    func testRepositoryProvidersDBEmpty() {
        
        // CASE 1 : db is empty, call api provider
        //Given
        let exp = expectation(description: "Download techologies")
        let fakeCache = CacheProviderFake()
        let fakeDB = DBProviderFake()
        fakeDB.returnsData = false
        let apiSpy = APIProviderSpy()
        let repository = Repository(apiProvider: apiSpy, cacheProvider: fakeCache, dbProvider: fakeDB)
        
        //When
        let task: Task<[TechnologyModel]> = repository.retrieveDBTechnologies()
        task.upon(.main) { (result) in
            switch result {
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTAssert(false)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        if apiSpy.isCalled {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testRepositoryProvidersDBFull() {
        
        // CASE 2 : db is full, don't call api provider
        //Given
        let fakeCache = CacheProviderFake()
        let fakeDB = DBProviderFake()
        fakeDB.returnsData = true
        let apiSpy = APIProviderSpy()
        let repository = Repository(apiProvider: apiSpy, cacheProvider: fakeCache, dbProvider: fakeDB)
        
        //When
        let _ = repository.retrieveDBTechnologies()
        
        //Then
        if apiSpy.isCalled {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }

}
