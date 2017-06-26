//
//  HiringAppTests.swift
//  HiringAppTests
//
//  Created by Alejandro Garcia on 14/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
@testable import HiringAppCore
import Deferred
import Decodable
@testable import BSWFoundation

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

class APIProviderSpy: APIProviderType {
    
    var isCalled: Bool = false
    
    func retrieveTechnologies() -> Task<[TechnologyModel]> {
        isCalled = true
        return Task(success: [TechnologyModel].fake)
    }
}

class HiringAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let  cacheProvider = CacheProvider()
        cacheProvider.removeTechnologies()
        
        let dbProvider = DBProvider()
        dbProvider.clearAll()
        super.tearDown()
    }
    
    func testParser() {
        //Given
        let data = Data(contentsOfJSONFile: "technologies", bundle: Bundle(for: type(of: self)))
        
        //When
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let model = try [TechnologyModel].decode(json)
            XCTAssertFalse(model.isEmpty)
        } catch {
            XCTAssert(false)
        }
        //Then
    }
    
    func testAPIProviderWithFakeDrosky() {
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
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRealAPIProvider() {
        let exp = expectation(description: "Wait for drosky to perform the taks")
        //Given
        let provider = APIProvider(drosky: Drosky(environment: DevelopmentEnvironment()))
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
    
    func testRepositoryProvidersCacheEmpty() {

        // CASE 1 : cache is empty, call api provider
        //Given
        let exp = expectation(description: "Download techologies")
        let fakeCache = CacheProviderFake()
        fakeCache.isEmpty = true
        let apiSpy = APIProviderSpy()
        let repository = Repository(apiProvider: apiSpy, cacheProvider: fakeCache)
        
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
        let repository = Repository(apiProvider: apiSpy, cacheProvider: fakeCache)
        
        //When
        let _ = repository.retrieveTechnologies()
        
        //Then
        if apiSpy.isCalled {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    func testTransformTechnologyRealmToTechnologyModel() {
        
        let fakeTechRealm = TechnologyRealm.fake
        let fakeTechModel = fakeTechRealm.transformToTechnologyModel()
        
        guard let fakeTechModelReceived = fakeTechModel else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(fakeTechRealm.id == fakeTechModelReceived.id)
        XCTAssert(fakeTechRealm.title == fakeTechModelReceived.title)
        XCTAssert(fakeTechRealm.imageURL == fakeTechModelReceived.imageURL)
        XCTAssert(fakeTechRealm.testAvailable == fakeTechModelReceived.testAvailable)
        
        if let realmSubmittedTest: String = fakeTechRealm.submittedTest?["status"] as? String {
            XCTAssert(realmSubmittedTest == fakeTechModelReceived.submittedTest?["status"])
        }
    }

    
    func testDBProvider() {        
        let fakeTech = [TechnologyRealm].fakeArray
        //Given
        let dbProvider = DBProvider()
        
        //When
        fakeTech.forEach { (tech) in
            dbProvider.write(tech: tech)
        }
        
        //Then
        let tech: [TechnologyRealm]? = dbProvider.read()
        
        guard let techReceived = tech else {
            XCTAssert(false)
            return
        }
        
        for i in  stride(from: 0, to: fakeTech.count, by: 1) {
        
            XCTAssert(fakeTech[i].id == techReceived[i].id)
            XCTAssert(fakeTech[i].title == techReceived[i].title)
            XCTAssert(fakeTech[i].imageURL == techReceived[i].imageURL)
            XCTAssert(fakeTech[i].testAvailable == techReceived[i].testAvailable)
            
            if let realmSubmittedTest: String = fakeTech[i].submittedTest?["status"] as? String ,
                let techReceivedTest: String = techReceived[i].submittedTest?["status"] as? String{
                XCTAssert(realmSubmittedTest == techReceivedTest)
            }
        }
    }
    
}



