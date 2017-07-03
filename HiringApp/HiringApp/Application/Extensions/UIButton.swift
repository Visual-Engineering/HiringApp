//
//  UIButton.swift
//  HiringApp
//
//  Created by Margareta Kusan on 03/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

extension UIButton {
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
            } else {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.setStyledTitleColor(self.titleColor(for: .normal)!.withAlphaComponent(1))
            } else {
                self.setStyledTitleColor(self.titleColor(for: .normal)!.withAlphaComponent(0.5))
            }
        }
    }
}
