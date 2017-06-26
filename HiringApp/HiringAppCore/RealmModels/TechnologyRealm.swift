//
//  TechnologyRealm.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation
import RealmSwift


public class TechnologyRealm: Object {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var imageURL = ""
    dynamic var testAvailable = false
    dynamic var submittedTest: Test?
}

public class Test: Object {
    dynamic var status = ""
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

extension TechnologyModel {
    func transformToTechnologyRealm() -> TechnologyRealm? {
        let techRealm = TechnologyRealm()
        techRealm.id = self.id
        techRealm.title = self.title
        techRealm.imageURL = self.imageURL
        techRealm.testAvailable = self.testAvailable
        if let status = self.submittedTest?["status"] {
            let test = Test()
            test.status = status
            techRealm.submittedTest = test
        }
        techRealm.submittedTest = nil
        return techRealm
    }
}
