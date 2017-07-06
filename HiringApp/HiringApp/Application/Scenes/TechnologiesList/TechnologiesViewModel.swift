//
//  TechnologiesViewModel.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

struct TechnologiesViewModel {
    let techs: [TechnologyViewModel]
}

struct TechnologyViewModel {
    public let id: Int
    public let title: String
    public let imageURL: String
    public let testAvailable: Bool
    public let submittedTest: [String : String]?
}

extension TechnologyViewModel: Equatable {
    
    public static func ==(lhs: TechnologyViewModel, rhs: TechnologyViewModel) -> Bool {
        
        let idsEqual = (lhs.id == rhs.id)
        let titleEqual = (lhs.title == rhs.title)
        let imgEqual = (lhs.imageURL == rhs.imageURL)
        let testEqual = (lhs.testAvailable == rhs.testAvailable)
        let submittedEqual: Bool = {
            switch (lhs.submittedTest, rhs.submittedTest) {
            case (nil, nil):
                return true
            case (_, nil):
                return false
            case (nil, _):
                return false
            default:
                guard let leftText = lhs.submittedTest, let rightText = rhs.submittedTest else { fatalError() }
                return leftText == rightText
            }
        }()
        return idsEqual && titleEqual && imgEqual && testEqual && submittedEqual
    }
}

extension TechnologiesViewModel: Equatable {
    
    public static func ==(lhs: TechnologiesViewModel, rhs: TechnologiesViewModel) -> Bool {
        let techsEqual = (lhs.techs == rhs.techs)
        return techsEqual
    }
}

