//
//  AvenirTypeface.swift
//  HiringApp
//
//  Created by Jordi Aguila on 26/06/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

struct AvenirTypeface {
}

extension AvenirTypeface: TypefaceStyleable {
    
    static func styleFontNameFor(weight: CGFloat) -> String {
        
        switch weight {
        case UIFontWeightUltraLight: fallthrough
        case UIFontWeightLight: fallthrough
        case UIFontWeightThin:
            return "Avenir-Light"
            
        case UIFontWeightRegular:
            return "Avenir-Book"
            
        case UIFontWeightMedium: fallthrough
        case UIFontWeightSemibold: fallthrough
        case UIFontWeightBold:
            return "Avenir-Medium"
            
        case UIFontWeightHeavy:
            return "Avenir-Heavy"
            
        case UIFontWeightBlack:
            return "Avenir-Black"
            
        default:
            return "Avenir-Book"
        }
    }
}
