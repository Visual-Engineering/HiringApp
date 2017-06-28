//
//  TopicModel.swift
//  Pods
//
//  Created by Alba Luján on 27/6/17.
//
//

import Foundation
import Decodable

public struct TopicModel {
    public let topicId: Int
    public let title: String
    public let technologyId: Int
}

extension TopicModel: Decodable {
    
    public static func decode(_ json: Any) throws -> TopicModel {
        return try TopicModel(
            topicId: json => "id",
            title: json => "title",
            technologyId: json => "technologyId")
    }
}
