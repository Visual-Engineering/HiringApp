//
//  NSBundle.swift
//  Pods
//
//  Created by Alba Luján on 21/6/17.
//
//

import Foundation

class BundleDummyTracker {}

extension Bundle {
    
    class func currentBundle() -> Bundle {
        guard let bundleURL = Bundle(for: BundleDummyTracker.self).url(forResource: "HiringAppCoreBundle", withExtension: "bundle") else {
            return Bundle.main
        }
        return Bundle(url: bundleURL)!
    }
    
    class func jsonData(named: String) -> Data? {
        guard let existingURL = currentBundle().url(forResource: named, withExtension: "json") else {
            return nil
        }
        
        return try? Data(contentsOf: existingURL)
    }
}


extension Optional where Wrapped: Equatable {
    static func  ==(left: Optional, right: Optional) -> Bool {
        switch (left, right) {
        case (nil, nil):
            return true
        case (nil, _):
            return false
        case (_, nil):
            return false
        default:
            return left! == right!
        }
    }
}
