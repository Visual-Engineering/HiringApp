//
//  Endpoints.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation
import BSWFoundation

enum AppEndpoints {
    case technologies
    case candidate(parameters: [String : AnyObject])
    case authenticate(deviceID: String)
    case topics(technologyId: Int)
}

extension AppEndpoints: Endpoint {
    
    var path: String {
        switch self {
        case .technologies:
            return "/technologies"
        case .candidate:
            return "/contact"
        case .authenticate:
            return "/users"
        case .topics(let technologyId):
            return "/technologies/\(technologyId)/topics"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .technologies, .topics:
            return .GET
        case .candidate, .authenticate:
            return .POST
        }
    }
    
    var httpHeaderFields: [String : String]? {
        switch self {
        case .candidate:
            return ["Content-Type": "application/json"]
        case .technologies, .topics, .authenticate:
            return nil
        }
    }
    
    var parameters: [String : AnyObject]? {
        switch self {
        case .authenticate(let deviceID):
            return ["deviceId": deviceID as AnyObject]
        case .candidate(let parameters):
            return parameters
        case .technologies, .topics:
            return nil
        }
    }
}
