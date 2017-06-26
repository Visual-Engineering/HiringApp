//
//  TechnologyModel.swift
//  Pods
//
//  Created by Alba Luján on 21/6/17.
//
//

import Foundation
import Decodable

public struct TechnologyModel {
    public let id: Int
    public let title: String
    public let imageURL: String
    public let testAvailable: Bool
    public let submittedTest: [String : String]?
}

extension TechnologyModel: Decodable {
    
    public static func decode(_ json: Any) throws -> TechnologyModel {
        return try TechnologyModel(
            id: json => "id",
            title: json => "title",
            imageURL: json => "imageURL",
            testAvailable: json => "testAvailable",
            submittedTest: json =>? "submittedTest")
    }
}

extension TechnologyModel: Equatable {
    public static func ==(lhs: TechnologyModel, rhs: TechnologyModel) -> Bool {

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
