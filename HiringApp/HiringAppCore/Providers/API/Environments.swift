//
//  Environments.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation
import BSWFoundation

struct DevelopmentEnvironment: Environment {
    var basePath: String {
        return "http://private-60454-visualtestapp.apiary-mock.com"
    }
}
