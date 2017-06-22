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
