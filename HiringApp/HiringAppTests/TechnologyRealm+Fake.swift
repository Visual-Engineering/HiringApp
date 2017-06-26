//
//  TechnologyRealm+Fake.swift
//  HiringApp
//
//  Created by Alba Luján on 26/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation
@testable import HiringAppCore
import RealmSwift

extension TechnologyRealm {
    static var fake: TechnologyRealm {
        return {
            let techObj = TechnologyRealm()
            techObj.id = 0
            techObj.title = "iOS"
            techObj.imageURL = ""
            techObj.testAvailable = false
            techObj.submittedTest = nil
            return techObj
        }()
    }
    
    static var fakeWithTest: TechnologyRealm {
        return {
            let techObj = TechnologyRealm()
            techObj.id = 0
            techObj.title = "iOS"
            techObj.imageURL = ""
            techObj.testAvailable = false
            let test = Test()
            test.status = "blabla"
            techObj.submittedTest = test
            return techObj
            }()
    }
}

extension TechnologyRealm {
    
    func transformToTechnologyModel() -> TechnologyModel? {
        var submittedTest: [String: String]? = [String: String]()
        if let status = self.submittedTest?.status {
            submittedTest!["status"] = status
        } else { submittedTest = nil }
        return TechnologyModel(id: self.id, title: self.title, imageURL: self.imageURL, testAvailable: self.testAvailable, submittedTest: submittedTest)
    }
}


extension Array where Element == TechnologyRealm {
    static var fakeArray: [TechnologyRealm] {
        return [ TechnologyRealm.fake,
                  TechnologyRealm.fakeWithTest,
                  TechnologyRealm.fake]
    }
    }
