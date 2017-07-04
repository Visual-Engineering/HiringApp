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
                NSFontAttributeName: AvenirTypeface.caption2,
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

protocol TextStylable: class {
    var styledText: String? { get set }
    var style: Style? { get set }
}

protocol TextPropertiesInterface: class {
    var opaqueAttributedText: NSAttributedString? { get set }
    var opaqueText: String? { get set }
}

var keyPointer: NSString = ""

extension TextStylable where Self: TextPropertiesInterface {
    
    var styledText: String? {
        set {
            guard let style = style else {
                opaqueText = newValue
                return
            }
            
            if let newValue = newValue {
                opaqueAttributedText = newValue.attributedWith(style: style)
            } else {
                opaqueText = nil
            }
        }
        get {
            return opaqueText
        }
    }
    
    var style: Style? {
        set {
            if style != newValue {
                objc_setAssociatedObject(self, &keyPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                if let text = opaqueText {
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


//MARK: - UIKit extensions

extension UILabel: TextPropertiesInterface, TextStylable {
    
    var opaqueAttributedText: NSAttributedString? {
        get { return attributedText }
        set { attributedText = newValue}
    }
    var opaqueText: String? {
        get { return text }
        set { text = newValue}
    }
}

extension UITextField: TextPropertiesInterface, TextStylable {
    
    var opaqueAttributedText: NSAttributedString? {
        get { return attributedText }
        set { attributedText = newValue}
    }
    var opaqueText: String? {
        get { return text }
        set { text = newValue}
    }
}

extension UITextView: TextPropertiesInterface, TextStylable {
    
    var opaqueAttributedText: NSAttributedString? {
        get { return attributedText }
        set { attributedText = newValue}
    }
    var opaqueText: String? {
        get { return text }
        set { text = newValue}
    }
}

extension UIButton: TextPropertiesInterface, TextStylable {
    
    var opaqueAttributedText: NSAttributedString? {
        get { return attributedTitle(for: .normal) }
        set { setAttributedTitle(newValue, for: .normal) }
    }
    var opaqueText: String? {
        get { return title(for: .normal) }
        set { setTitle(newValue, for: .normal)}
    }
    
    //Fix UIKit issue when handling title color and NSAttributedStrings (setTitleColor fails to update titleLabel color)
    func setStyledTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
        titleLabel?.textColor = color
    }
}
