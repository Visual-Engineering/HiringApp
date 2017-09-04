//
//  NSString.swift
//  HiringApp
//
//  Created by Jordi Aguila on 27/06/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

extension NSString {
    
    func attributedWith(style: Style,
                        alignment: NSTextAlignment? = nil,
                        lineBreakMode: NSLineBreakMode? = nil,
                        color: UIColor? = nil) -> NSAttributedString {
        
        var attributes = style.styleDictionary()
        
        //Append foreground color
        attributes[NSForegroundColorAttributeName] = color
        
        //Update/Add paragraph related styles (if any)
        if lineBreakMode != nil || alignment != nil {
            
            let paragraphStyle = attributes[NSParagraphStyleAttributeName] as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment ?? paragraphStyle.alignment
            paragraphStyle.lineBreakMode = lineBreakMode ?? paragraphStyle.lineBreakMode
            attributes[NSParagraphStyleAttributeName] = paragraphStyle
        }
        
        return NSAttributedString(string: self as String, attributes: attributes)
    }
}
