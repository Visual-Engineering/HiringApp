//
//  Stylesheet.swift
//  HiringApp
//
//  Created by Jordi Aguila on 27/06/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

//MARK: - Available text styles

enum Style {
    case body
    case callout
    case caption1
    case caption2
    case footnote
    case headline
    case subheadline
    case title1
    case title2
    case title3
}

extension Style {

    func styleDictionary() -> [String : Any] {
        
        switch self {
        case .body:
            return [
                NSFontAttributeName: AvenirTypeface.body,
                NSKernAttributeName: -0.5
            ]
        case .callout:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2.0
            
            return [
                NSFontAttributeName: AvenirTypeface.callout,
                NSKernAttributeName: 0.1,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
        case .caption1:
            return [
                NSFontAttributeName: AvenirTypeface.caption1
            ]
        case .caption2:
            return [
                NSFontAttributeName: AvenirTypeface.caption2
            ]
        case .footnote:
            return [
                NSFontAttributeName: AvenirTypeface.footnote
            ]
        case .headline:
            return [
                NSFontAttributeName: AvenirTypeface.headline
            ]
        case .subheadline:
            return [
                NSFontAttributeName: AvenirTypeface.subheadline
            ]
        case .title1:
            return [
                NSFontAttributeName: SystemTypeface.title1
            ]
        case .title2:
            return [
                NSFontAttributeName: SystemTypeface.title2
            ]
        case .title3:
            return [
                NSFontAttributeName: SystemTypeface.title3
            ]
        }
    }
}

//MARK: - TextStylable protocol

protocol TextStylable {
    var styledText: String? { get set }
    var style: Style? { get set }
}

//MARK: - UIKit extensions

let keyPointer: String = ""

extension TextStylable where Self: UILabel {
    
    var styledText: String? {
        set {
            guard let style = style else {
                text = newValue
                return
            }
            
            if let newValue = newValue {
                attributedText = newValue.attributedWith(style: style)
            } else {
                text = nil
            }
        }
        get {
            return text
        }
    }
    
    var style: Style? {
        set {
            if style != newValue {
                objc_setAssociatedObject(self, &keyPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                if let text = text {
                    styledText = text
                }
            }
        }
        
        get {
            
            if let associatedObject: Style = objc_getAssociatedObject(self, &keyPointer) as? Style {
                return associatedObject
            }
            return nil
        }
    }
}

extension UILabel: TextStylable { }

extension TextStylable where Self: UITextView {
    
    var styledText: String? {
        set {
            guard let style = style else {
                text = newValue
                return
            }
            
            if let newValue = newValue {
                attributedText = newValue.attributedWith(style: style)
            } else {
                text = nil
            }
        }
        get {
            return text
        }
    }
    
    var style: Style? {
        set {
            if style != newValue {
                objc_setAssociatedObject(self, &keyPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                if let text = text {
                    styledText = text
                }
            }
        }
        
        get {
            
            if let associatedObject: Style = objc_getAssociatedObject(self, &keyPointer) as? Style {
                return associatedObject
            }
            return nil
        }
    }
}

extension UITextView: TextStylable { }

extension TextStylable where Self: UITextField {
    
    var styledText: String? {
        set {
            guard let style = style else {
                text = newValue
                return
            }
            
            if let newValue = newValue {
                attributedText = newValue.attributedWith(style: style)
            } else {
                text = nil
            }
        }
        get {
            return text
        }
    }
    
    var style: Style? {
        set {
            if style != newValue {
                objc_setAssociatedObject(self, &keyPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                if let text = text {
                    styledText = text
                }
            }
        }
        
        get {
            
            if let associatedObject: Style = objc_getAssociatedObject(self, &keyPointer) as? Style {
                return associatedObject
            }
            return nil
        }
    }
}

extension UITextView: UITextField { }

