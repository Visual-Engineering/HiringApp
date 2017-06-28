//
//  Environments.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation
import BSWFoundation

enum EnvironmentType {
    case development
}

extension EnvironmentType: Environment {
    
    var basePath: String {
        switch self {
        case .development:
            return "http://private-60454-visualtestapp.apiary-mock.com"
        }
    }
}
