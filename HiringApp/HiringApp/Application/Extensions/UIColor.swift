//
//  UIColor.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 05/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func brandBlueColor() -> UIColor {
        return Palette.brandBlueColor
    }
    
    struct Palette {
        static var brandBlueColor: UIColor {
            return UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
        }
    }
}
