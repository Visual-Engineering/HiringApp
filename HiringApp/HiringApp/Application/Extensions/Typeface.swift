//
//  Typeface.swift
//  HiringApp
//
//  Created by Jordi Aguila on 26/06/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

protocol TypefaceCategoriesProtocol {
    static var body: UIFont { get }
    static var callout: UIFont { get }
    static var caption1: UIFont { get }
    static var caption2: UIFont { get }
    static var footnote: UIFont { get }
    static var headline: UIFont { get }
    static var subheadline: UIFont { get }
    static var title1: UIFont { get }
    static var title2: UIFont { get }
    static var title3: UIFont { get }
}

protocol TypefaceStyleable: TypefaceCategoriesProtocol {
    static func styleFontNameFor(weight: CGFloat) -> String
}

extension TypefaceStyleable {
    
    ///Dynamic types
    static var body: UIFont {
        return concreteFont(forSize: SystemTypeface.body.pointSize, andWeight: UIFontWeightRegular)
    }
    
    static var callout: UIFont {
        return concreteFont(forSize: SystemTypeface.callout.pointSize, andWeight: UIFontWeightRegular)
    }
    
    static var caption1: UIFont {
        return concreteFont(forSize: SystemTypeface.caption1.pointSize, andWeight: UIFontWeightRegular)
    }
    
    static var caption2: UIFont {
        return concreteFont(forSize: SystemTypeface.caption2.pointSize, andWeight: UIFontWeightRegular)
    }
    
    static var footnote: UIFont {
        return concreteFont(forSize: SystemTypeface.footnote.pointSize, andWeight: UIFontWeightRegular)
    }
    
    static var headline: UIFont {
        return concreteFont(forSize: SystemTypeface.headline.pointSize, andWeight: UIFontWeightBold)
    }
    
    static var subheadline: UIFont {
        return concreteFont(forSize: SystemTypeface.subheadline.pointSize, andWeight: UIFontWeightRegular)
    }
    
    static var title1: UIFont {
        return concreteFont(forSize: SystemTypeface.title1.pointSize, andWeight: UIFontWeightLight)
    }
    
    static var title2: UIFont {
        return concreteFont(forSize: SystemTypeface.title2.pointSize, andWeight: UIFontWeightRegular)
    }
    
    static var title3: UIFont {
        return concreteFont(forSize: SystemTypeface.title3.pointSize, andWeight: UIFontWeightRegular)
    }
    
    static func concreteFont(forSize size: CGFloat, andWeight weight: CGFloat) -> UIFont {
        return UIFont(name: styleFontNameFor(weight: weight), size: size)!
    }
}


struct SystemTypeface: TypefaceCategoriesProtocol {
    
    ///Dynamic types
    static var body: UIFont {
        return UIFont.preferredFont(forTextStyle: .body)
    }
    
    static var callout: UIFont {
        return UIFont.preferredFont(forTextStyle: .callout)
    }
    
    static var caption1: UIFont {
        return UIFont.preferredFont(forTextStyle: .caption1)
    }
    
    static var caption2: UIFont {
        return UIFont.preferredFont(forTextStyle: .caption2)
    }
    
    static var footnote: UIFont {
        return UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    static var headline: UIFont {
        return UIFont.preferredFont(forTextStyle: .headline)
    }
    
    static var subheadline: UIFont {
        return UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    static var title1: UIFont {
        return UIFont.preferredFont(forTextStyle: .title1)
    }
    
    static var title2: UIFont {
        return UIFont.preferredFont(forTextStyle: .title2)
    }
    
    static var title3: UIFont {
        return UIFont.preferredFont(forTextStyle: .title3)
    }
}
