//
//  LabelHelper.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 05/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

enum WalkthroughLabel {
    case title
    case subtitle
}

struct LabelHelper {
    
    struct Walkthrough {
        static func setup(label: UILabel?, type: WalkthroughLabel, text: String?) {
            guard var label = label else {
                return
            }
            
            switch type {
            case .title:
                label.styledText = text
                label.style = .title1
                label.numberOfLines = 1
                label.textColor = .white
                label.text = text
                label.sizeToFit()
                label.textAlignment = .center

            case .subtitle:
                label.styledText = text
                label.style = .body
                label.numberOfLines = 3
                label.textColor = .white
                label.text = text
                label.sizeToFit()
                label.textAlignment = .center
            }
        }

    }
    
}
