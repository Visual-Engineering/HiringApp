//
//  UtilityTests.swift
//  HiringApp
//
//  Created by Alba Luján on 26/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
@testable import HiringAppCore
import Deferred
@testable import BSWFoundation

class UtilityTests: XCTestCase {
    
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
    
    func testTransformTechnologyModelToTechnologyRealm() {
        
        let fakeTechModel = TechnologyModel.fake
        let fakeTechRealm = fakeTechModel.transformToTechnologyRealm()
        
        guard let fakeTechRealmReceived = fakeTechRealm else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(fakeTechModel.id == fakeTechRealmReceived.id)
        XCTAssert(fakeTechModel.title == fakeTechRealmReceived.title)
        XCTAssert(fakeTechModel.imageURL == fakeTechRealmReceived.imageURL)
        XCTAssert(fakeTechModel.testAvailable == fakeTechRealmReceived.testAvailable)
        
        if let realmSubmittedTest: String = fakeTechRealmReceived.submittedTest?["status"] as? String {
            XCTAssert(realmSubmittedTest == fakeTechModel.submittedTest?["status"])
        }
    }
    
    func testModelToJSON() {
        //Given
        let candidate = CandidateModel.fake
        
        //When
        _ = candidate.toJSON().upon(.main) { (result) in
            
            //Then
            switch result {
            case .success(let value):
                let jsonString = String(data: value, encoding: .utf8)
                //print(jsonString)
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
        }
    }
}
