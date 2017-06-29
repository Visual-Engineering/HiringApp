//
//  TechnologiesViewModel+Fake.swift
//  HiringApp
//
//  Created by Pablo Balduz on 29/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation
@testable import HiringApp
@testable import HiringAppCore

extension TechnologiesViewModel {
    static var fake: TechnologiesViewModel {
        
        return TechnologiesViewModel(title: "¿Cuál es tu tecnología?", techs: [TechnologyViewModel].fakeHiringAppTest)
    }
}


// Both TechnologyModel and TechnologyViewModel fakeHiringAppTest must always have the same data
extension Array where Element == TechnologyModel {
    static var fakeHiringAppTest: [TechnologyModel] {
        return [
            TechnologyModel(
                id: 1,
                title: "iOS",
                imageURL: "",
                testAvailable: true,
                submittedTest: ["status": "open"]
            ),
            TechnologyModel(
                id: 2,
                title: "android",
                imageURL: "",
                testAvailable: true,
                submittedTest: nil
            ),
            TechnologyModel(
                id: 3,
                title: "backend",
                imageURL: "",
                testAvailable: true,
                submittedTest: nil
            )]
    }
}

extension Array where Element == TechnologyViewModel {
    static var fakeHiringAppTest: [TechnologyViewModel] {
        return [
            TechnologyViewModel(
                id: 1,
                title: "iOS",
                imageURL: "",
                testAvailable: true,
                submittedTest: ["status": "open"]
            ),
            TechnologyViewModel(
                id: 2,
                title: "android",
                imageURL: "",
                testAvailable: true,
                submittedTest: nil
            ),
            TechnologyViewModel(
                id: 3,
                title: "backend",
                imageURL: "",
                testAvailable: true,
                submittedTest: nil
            )]
    }
}

