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

extension TopicModel {
    func topicsToDict() -> [String: Any] {
        
        let otherSelf = Mirror(reflecting: self)
        
        let optionalKeys = otherSelf.children.flatMap { (child) -> String? in
            if String(describing: type(of: child.value)).contains("Optional") {
                return child.label!
            }
            return nil
        }
        
        var dict = [String:Any]()
        for child in otherSelf.children {
            if let key = child.label {
                if optionalKeys.contains(key) {
                    if let _ = child.value as? Dictionary<String, Any> {
                        dict[key] = child.value
                    }
                } else {
                    dict[key] = child.value
                }
            }
        }
        return dict
    }
}
