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
