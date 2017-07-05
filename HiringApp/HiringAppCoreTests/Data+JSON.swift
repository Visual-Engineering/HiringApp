//
//  Data+JSON.swift
//  HiringApp
//
//  Created by Alba Luján on 21/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation

extension Data {
    
    init(contentsOfJSONFile file: String, bundle: Bundle) {
        guard let path = bundle.path(forResource: file, ofType: "json"),
            let jsonStr = try? String(contentsOfFile: path),
            let data = jsonStr.data(using: .utf8, allowLossyConversion: false) else {
                fatalError()
        }
        
        self = data
    }
}
