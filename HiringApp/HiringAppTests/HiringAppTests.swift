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

class HiringAppTests: XCTestCase {
    
    func testProvider() {
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
            case .failure(let _):
                XCTAssert(false)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
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
    
    func testRepository() {
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
            case .failure(let error):
                XCTAssert(false)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 60, handler: nil)
    }
}
