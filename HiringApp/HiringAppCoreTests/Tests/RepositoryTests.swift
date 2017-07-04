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
    
    func testRepositoryProvidersCacheEmpty() {
        
        // CASE 1 : cache is empty, call api provider
        //Given
        let exp = expectation(description: "Download techologies")
        let fakeCache = CacheProviderFake()
        fakeCache.isEmpty = true
        let apiSpy = APIProviderSpy()
        let dbProvider = DBProviderFake()
        guard let repository = TechsRepository(apiProvider: apiSpy, cacheProvider: fakeCache, dbProvider: dbProvider) else { fatalError() }
        
        //When
        let task: Task<[TechnologyModel]> = repository.retrieveAPITechnologies()
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
        guard let repository = TechsRepository(apiProvider: apiSpy, cacheProvider: fakeCache, dbProvider: dbProvider) else { fatalError() }
        
        //When
        let _ = repository.retrieveAPITechnologies()
        
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
        guard let repository = TechsRepository(apiProvider: apiSpy, cacheProvider: fakeCache, dbProvider: fakeDB) else { fatalError() }
        
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
        guard apiSpy.isCalled else {
            XCTAssert(false)
            return
        }
    }
    
    func testRepositoryProvidersDBFull() {
        
        // CASE 2 : db is full, don't call api provider
        //Given
        let fakeCache = CacheProviderFake()
        let fakeDB = DBProviderFake()
        fakeDB.returnsData = true
        let apiSpy = APIProviderSpy()
        guard let repository = TechsRepository(apiProvider: apiSpy, cacheProvider: fakeCache, dbProvider: fakeDB) else { fatalError() }
        
        //When
        let _ = repository.retrieveDBTechnologies()
        
        //Then
        guard !apiSpy.isCalled else {
            XCTAssert(false)
            return
        }

    }
    
    func testContactFormRepository() {
        //Given 
        let contactFormData = CandidateModel.fake
        let apiSpy = APIProviderSpy()
        let repository = ContactFormRepository(apiProvider: apiSpy)
        
        
        //When
        _ = repository?.sendContactFormData(candidate: contactFormData)
        
        //Then
        guard apiSpy.isCalled else {
            XCTAssert(false)
            return
        }
    }

}
