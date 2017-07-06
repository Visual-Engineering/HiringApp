//
//  CandidateModel+Fake.swift
//  HiringApp
//
//  Created by Alba Luján on 26/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//


import Foundation
@testable import HiringAppCore

extension CandidateModel {
    static var fake: CandidateModel {
        return CandidateModel(
            name: "Alejandro",
            lastname: "García",
            linkedin: "https://www.linkedin.com/...",
            phone: "666777888",
            email: "agarcia@visualengin.com"
        )
    }
}
