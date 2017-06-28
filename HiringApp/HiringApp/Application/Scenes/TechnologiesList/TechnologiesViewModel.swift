//
//  TechnologiesViewModel.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import HiringAppCore

struct TechnologiesViewModel {
    let title: String
    let techs: [TechnologyViewModel]
}

extension TechnologiesViewModel {
    init(technologies: [TechnologyViewModel], title: String) {
        self.techs = technologies
        self.title = title
    }
}

struct TechnologyViewModel {
    public let id: Int
    public let title: String
    public let imageURL: String
    public let testAvailable: Bool
    public let submittedTest: [String : String]?
}
