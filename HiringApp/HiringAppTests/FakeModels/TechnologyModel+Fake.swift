//
//  TechnologyModel+Fake.swift
//  HiringApp
//
//  Created by Alba Luján on 21/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation
@testable import HiringAppCore

extension TechnologyModel {
    static var fake: TechnologyModel {
        return TechnologyModel(
            id: 1,
            title: "iOS",
            imageURL: "",
            testAvailable: true,
            submittedTest: nil
        )
    }
}

extension Array where Element == TechnologyModel {
    static var fake: [TechnologyModel] {
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
