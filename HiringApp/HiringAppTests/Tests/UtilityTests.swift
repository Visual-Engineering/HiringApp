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
        let fakeTechModel = fakeTechRealm.toModel
        
        XCTAssert(fakeTechRealm.id == fakeTechModel.id)
        XCTAssert(fakeTechRealm.title == fakeTechModel.title)
        XCTAssert(fakeTechRealm.imageURL == fakeTechModel.imageURL)
        XCTAssert(fakeTechRealm.testAvailable == fakeTechModel.testAvailable)
        
        if let realmSubmittedTest: String = fakeTechRealm.submittedTest?["status"] as? String {
            XCTAssert(realmSubmittedTest == fakeTechModel.submittedTest?["status"])
        }
    }
    
    func testTransformTechnologyModelToTechnologyRealm() {
        
        let fakeTechModel = TechnologyModel.fake
        let fakeTechRealm = fakeTechModel.toRealmModel

        
        XCTAssert(fakeTechModel.id == fakeTechRealm.id)
        XCTAssert(fakeTechModel.title == fakeTechRealm.title)
        XCTAssert(fakeTechModel.imageURL == fakeTechRealm.imageURL)
        XCTAssert(fakeTechModel.testAvailable == fakeTechRealm.testAvailable)
        
        if let realmSubmittedTest: String = fakeTechRealm.submittedTest?["status"] as? String {
            XCTAssert(realmSubmittedTest == fakeTechModel.submittedTest?["status"])
        }
    }

}
