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
        
        let resourceURL = currentBundle().url(forResource: named, withExtension: "json")
        
        guard let existingURL = resourceURL else {
            return nil
        }
        
        return try? Data(contentsOf: existingURL)
    }
}
