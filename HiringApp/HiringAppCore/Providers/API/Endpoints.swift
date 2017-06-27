//
//  Endpoints.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation
import BSWFoundation

struct TechologiesEndpoint: Endpoint {
    /// The path for the request
    var path: String { return "/technologies" }
}

struct CandidateEndpoint: Endpoint {
    var path: String { return "/contact" }
    var method: HTTPMethod = .POST
    var parameters: [String : AnyObject]?
    var httpHeaderFields: [String : String]? = ["Content-Type": "application/json"]
}

struct AuthenticateEndpoint: Endpoint {
    var path: String { return "/users" }
    var method: HTTPMethod = .POST
    var parameters: [String : AnyObject]? = ["deviceId": UIDevice.current.identifierForVendor?.uuidString as AnyObject]
}
