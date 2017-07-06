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
        return TechnologiesViewModel(techs: [TechnologyViewModel].fake)
    }
}

extension Array where Element == TechnologyViewModel {
    static var fake: [TechnologyViewModel] {
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

