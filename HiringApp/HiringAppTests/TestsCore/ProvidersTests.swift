//
//  ProvidersTests.swift
//  HiringApp
//
//  Created by Alba Luján on 26/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
import Deferred
@testable import HiringAppCore
@testable import BSWFoundation
import Decodable

class DroskyFake : DroskyType {
    func performRequest(forEndpoint endpoint: Endpoint) -> Task<DroskyResponse> {
        
        let droskyResponseFake = DroskyResponse(
            statusCode: 200,
            httpHeaderFields: [:],
            data: Data(contentsOfJSONFile: "technologies", bundle: Bundle(for: type(of: self)))
        )
        
        return Task(success: droskyResponseFake)
    }
}

class CacheProviderFake: CacheProviderType {
    
    var isEmpty: Bool = true
    var isSaved: Bool = false
    
    func getTechnologies() -> [TechnologyModel]?{
        if isEmpty {
            return nil
        }
        return [TechnologyModel].fake
    }
    
    func saveTechnologies(technologies: [TechnologyModel]) -> Task<()>{
        isSaved = true
        return Task(success: ())
    }
}

class DBProviderFake: DBProviderType {
    
    var returnsData: Bool = true
    var savesData: Bool = true
    
    func write(tech: TechnologyRealm) -> Task<()> {
        if savesData == false {
            return Task(failure: RepositoryError.noData)
        }
        return Task(success: ())
    }
    func read() -> [TechnologyRealm]? {
        if returnsData == false {
            return nil
        }
        return [TechnologyRealm].fakeArray
    }
}

class APIProviderSpy: APIProviderType {
    
    var isCalled: Bool = false
    
    func retrieveTechnologies() -> Task<[TechnologyModel]> {
        isCalled = true
        return Task(success: [TechnologyModel].fake)
    }
}

class ProvidersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let  cacheProvider = CacheProvider()
        cacheProvider.removeTechnologies()
        
        guard let dbProvider = DBProvider() else { fatalError() }
        dbProvider.clearAll()
        super.tearDown()
    }

    func testAPIProviderWithFakeDroskyForTechnologies() {
        let exp = expectation(description: "Wait for drosky to perform the taks")
        
        //Given
        let provider = APIProvider(drosky: DroskyFake())
        
        //When
        let task: Task<[TechnologyModel]> = provider.retrieveTechnologies()
        
        //Then
        task.upon(.main) { (result) in
            switch result {
            case .success(let value):
                XCTAssertFalse(value.isEmpty)
                XCTAssert(value.count == 5)
            case .failure(_):
                XCTAssert(false)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRetrieveTechnologies() {
        let exp = expectation(description: "Wait for drosky to perform the taks")
        //Given
        let provider = APIProvider(drosky: Drosky(environment: EnvironmentType.development))
        //When
        let task: Task<[TechnologyModel]> = provider.retrieveTechnologies()
        //Then
        task.upon(.main) { (result) in
            switch result {
            case .success(let value):
                XCTAssertFalse(value.isEmpty)
            case .failure(_):
                XCTAssert(false)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    
    func testStoreDataCacheProvider() {
        //Given
        let provider = CacheProvider()
        
        //When
        _ = provider.saveTechnologies(technologies: [TechnologyModel].fake)
        let technologies = provider.getTechnologies()
        
        //Then
        guard let tech = technologies else {
            XCTAssert(false)
            return
        }
        
        let fakeTech: [TechnologyModel] = [TechnologyModel].fake
        XCTAssert(tech == fakeTech)
    }
    
    func testDBProvider() {
        let fakeTech = [TechnologyRealm].fakeArray
        //Given
        guard let dbProvider = DBProvider() else { fatalError() }
        fakeTech.forEach { (tech) in
            _ = dbProvider.write(tech: tech)
        }
        
        //When
        let tech: [TechnologyRealm]? = dbProvider.read()
        
        //Then
        
        guard let techReceived = tech else {
            XCTAssert(false)
            return
        }
        
        zip(fakeTech, techReceived).forEach { (realm, received) in
            XCTAssert(realm == received)
        }
    }
    
    func testAPIProviderWithFakeDroskyForAuthenticate() {
        let exp = expectation(description: "Wait for drosky to perform the taks")
        
        //Given
        let provider = APIProvider(drosky: Drosky(environment: EnvironmentType.development))
        
        //When
        let task: Task<String> = provider.performLogin()
        
        //Then
        task.upon(.main) { (result) in
            switch result {
            case .success(let value):
                XCTAssertFalse(value.isEmpty)
            case .failure(_):
                XCTAssert(false)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSendContactFormData() {
        let exp = expectation(description: "Wait for drosky to perform the taks")

        //Given
        let candidate = CandidateModel.fake
        let provider = APIProvider(drosky: Drosky(environment: EnvironmentType.development))
        
        //When
        let task: Task<(Data)> = provider.performContact(candidate: candidate)
        
        //Then
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
    }
    
    func testRetrieveTopics() {
        let exp = expectation(description: "Wait for drosky to perform the taks")

        //Given
        let provider = APIProvider(drosky: Drosky(environment: EnvironmentType.development))
        let technologyId = 0
        
        //When
        let task: Task<[TopicModel]> = provider.retrieveTopics(technologyId: technologyId)
        
        //Then
        task.upon(.main) { (result) in
            switch result {
            case .failure(_):
                XCTAssert(false)
            case .success(let value):
                XCTAssert(value.count != 0)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}

extension TechnologyRealm {
    static func  ==(left: TechnologyRealm, right: TechnologyRealm) -> Bool {
        let areEqual: Bool = (
            left.id == right.id &&
                left.title == right.title &&
                left.imageURL == right.imageURL &&
                left.testAvailable == right.testAvailable
        )
        
        guard areEqual else { return false }
        
        let realmSubmittedTest = left.submittedTest?["status"] as? String
        let techReceivedTest = right.submittedTest?["status"] as? String
        
        return realmSubmittedTest == techReceivedTest
    }
}

extension Optional where Wrapped: Equatable {
    static func  ==(left: Optional, right: Optional) -> Bool {
        switch (left, right) {
        case (nil, nil):
            return true
        case (nil, _):
            return false
        case (_, nil):
            return false
        default:
            return left! == right!
        }
    }
}

